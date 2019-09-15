load(
    "@io_bazel_rules_docker//container:layer_tools.bzl",
    _get_layers = "get_from_target",
    _layer_tools = "tools",
)
load(
    "@io_bazel_rules_docker//skylib:label.bzl",
    _string_to_label = "string_to_label",
)
load(
    "@io_bazel_rules_docker//skylib:path.bzl",
    _get_runfile_path = "runfile",
)

def _runfiles(ctx, f):
    return "${RUNFILES}/%s" % _get_runfile_path(ctx, f)

def _deduplicate(iterable):
    """Performs a deduplication (similar to `list(set(...))`)
    This is necessary because `set` is not available in Skylark.
    """
    return {k: None for k in iterable}.keys()

def _resolve(ctx, string, output):
    stamps = [ctx.info_file, ctx.version_file]
    stamp_args = [
        "--stamp-info-file=%s" % sf.path
        for sf in stamps
    ]
    ctx.actions.run(
        executable = ctx.executable._stamper,
        arguments = [
            "--format=%s" % string,
            "--output=%s" % output.path,
        ] + stamp_args,
        inputs = stamps,
        tools = [ctx.executable._stamper],
        outputs = [output],
        mnemonic = "Stamp",
    )

def _impl(ctx):
    """resolve a rules_docker container_image, push it and return its image_url"""

    all_inputs = []
    image_specs = []
    if ctx.attr.images:
        # Compute the set of layers from the image_targets.
        image_target_dict = _string_to_label(
            ctx.attr.image_targets,
            ctx.attr.image_target_strings,
        )

        for tag in ctx.attr.images:
            resolved_tag = ctx.expand_make_variables("tag", tag, {})
            target = ctx.attr.images[tag]
            image = _get_layers(ctx, ctx.label.name, image_target_dict[target])

            image_spec = {"name": resolved_tag}
            if image.get("legacy"):
                image_spec["tarball"] = _runfiles(ctx, image["legacy"])
                all_inputs += [image["legacy"]]

            blobsums = image.get("blobsum", [])
            image_spec["digest"] = ",".join([_runfiles(ctx, f) for f in blobsums])
            all_inputs += blobsums

            blobs = image.get("zipped_layer", [])
            image_spec["layer"] = ",".join([_runfiles(ctx, f) for f in blobs])
            all_inputs += blobs

            image_spec["config"] = _runfiles(ctx, image["config"])
            all_inputs += [image["config"]]

            # Quote the semi-colons so they don't complete the command.
            image_specs += ["';'".join([
                "%s=%s" % (k, v)
                for (k, v) in image_spec.items()
            ])]

    image_chroot_arg = ctx.attr.image_chroot
    image_chroot_arg = ctx.expand_make_variables("image_chroot", image_chroot_arg, {})
    if "{" in ctx.attr.image_chroot:
        image_chroot_file = ctx.actions.declare_file(ctx.label.name + ".image-chroot-name")
        _resolve(ctx, ctx.attr.image_chroot, image_chroot_file)
        image_chroot_arg = "$(cat %s)" % _runfiles(ctx, image_chroot_file)
        all_inputs += [image_chroot_file]

    ctx.actions.expand_template(
        template = ctx.file.template,
        substitutions = {
            key: ctx.expand_make_variables(key, value, {})
            for (key, value) in ctx.attr.substitutions.items()
        },
        output = ctx.outputs.substituted,
    )
    ctx.actions.expand_template(
        template = ctx.file._template,
        substitutions = {
            "%{image_chroot}": image_chroot_arg,
            "%{images}": " ".join([
                "--image_spec=%s" % spec
                for spec in image_specs
            ]),
            "%{resolver_args}": " ".join(ctx.attr.resolver_args or []),
            "%{resolver}": _runfiles(ctx, ctx.executable.resolver),
            "%{yaml}": _runfiles(ctx, ctx.outputs.substituted),
        },
        output = ctx.outputs.executable,
    )

    return [
        DefaultInfo(
            runfiles = ctx.runfiles(
                files = [
                    ctx.executable.resolver,
                    ctx.outputs.substituted,
                ] + all_inputs,
                transitive_files = ctx.attr.resolver[DefaultInfo].default_runfiles.files,
            ),
        ),
    ]

_resolve_image = rule(
    attrs = {
        "images": attr.string_dict(),
        "image_chroot": attr.string(mandatory = False),
        "image_targets": attr.label_list(allow_files = True),
        "image_target_strings": attr.string_list(),
        "resolver": attr.label(
            default = Label("//runtime/k8s:resolver.par"),
            cfg = "host",
            executable = True,
            allow_files = True,
        ),
        # Extra arguments to pass to the resolver.
        "resolver_args": attr.string_list(),
        "substitutions": attr.string_dict(),
        "template": attr.label(
            allow_single_file = [
                ".yaml",
                ".json",
            ],
            mandatory = True,
        ),
        "_stamper": attr.label(
            default = Label("//runtime/k8s:stamper.par"),
            cfg = "host",
            executable = True,
            allow_files = True,
        ),
        "_template": attr.label(
            default = Label("//runtime/k8s:resolve.sh.tpl"),
            allow_single_file = True,
        ),
    },
    executable = True,
    outputs = {
        "substituted": "%{name}.substituted.yaml",
    },
    implementation = _impl,
)

_implicit_attrs = [
    "visibility",
    "restricted_to",
    "compatible_with",
    "deprecation",
    "tags",
    "testonly",
    "features",
]

def _implicit_args_as_dict(**kwargs):
    implicit_args = {}
    for attr_name in _implicit_attrs:
        if attr_name in kwargs:
            implicit_args[attr_name] = kwargs[attr_name]

    return implicit_args

def resolve_image(name, **kwargs):
    for reserved in ["image_targets", "image_target_strings", "resolved"]:
        if reserved in kwargs:
            fail("reserved for internal use by docker_bundle macro", attr = reserved)

    implicit_args = _implicit_args_as_dict(**kwargs)

    kwargs["image_targets"] = _deduplicate(kwargs.get("images", {}).values())
    kwargs["image_target_strings"] = _deduplicate(kwargs.get("images", {}).values())

    _resolve_image(name = name, **kwargs)
