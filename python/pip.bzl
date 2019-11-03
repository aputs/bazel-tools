load("//:maybe.bzl", "maybe")

def _pip_import_impl(repository_ctx):
    repository_ctx.file("BUILD", """exports_files(["requirements.bzl"])""")
    result = repository_ctx.execute([
        "python3",
        repository_ctx.path(repository_ctx.attr._script),
        "--name",
        repository_ctx.attr.name,
        "--input",
        repository_ctx.path(repository_ctx.attr.requirements),
        "--output",
        repository_ctx.path("requirements.bzl"),
        "--directory",
        repository_ctx.path(""),
    ])

    if result.return_code:
        fail("pip_import failed: %s (%s)" % (result.stdout, result.stderr))

pip_import = repository_rule(
    attrs = {
        "requirements": attr.label(
            mandatory = True,
            allow_single_file = True,
        ),
        "_script": attr.label(
            executable = True,
            default = Label("//python/tools:piptool.par"),
            cfg = "host",
        ),
    },
    implementation = _pip_import_impl,
)

def setup_pip_dependencies():
    pass