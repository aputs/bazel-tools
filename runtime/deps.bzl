load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive", "http_file")

def setup_runtime_dependencies():
    _maybe(
        http_archive,
        name = "io_bazel_rules_docker",
        sha256 = "969448c6c358197265399f3c78a8ee09bbc47f8a00166277dd6803f104d30c22",
        strip_prefix = "rules_docker-983815aaecb88be1eff007608870db067efe0951",
        urls = ["https://github.com/bazelbuild/rules_docker/archive/983815aaecb88be1eff007608870db067efe0951.tar.gz"],
    )

    _maybe(
        http_file,
        name = "busybox",
        executable = True,
        sha256 = "b51b9328eb4e60748912e1c1867954a5cf7e9d5294781cae59ce225ed110523c",
        urls = ["https://busybox.net/downloads/binaries/1.27.1-i686/busybox"],
    )

    _maybe(
        http_archive,
        name = "distroless",
        sha256 = "14834aaf9e005b9175de2cfa2b420c80778880ee4d9f9a9f7f385d3b177abff7",
        strip_prefix = "distroless-fa0765cc86064801e42a3b35f50ff2242aca9998",
        urls = ["https://github.com/GoogleContainerTools/distroless/archive/fa0765cc86064801e42a3b35f50ff2242aca9998.tar.gz"],
    )

def _maybe(repo_rule, name, **kwargs):
    if name not in native.existing_rules():
        repo_rule(name = name, **kwargs)
