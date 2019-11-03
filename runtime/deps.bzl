load("//:maybe.bzl", "maybe")
load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive", "http_file")

def setup_runtime_dependencies():
    maybe(
        http_archive,
        name = "distroless",
        sha256 = "b5451b114a1dfe5408057824b5ebcb4eabe627d0f8cc6757376502ffa445ebb6",
        strip_prefix = "distroless-aa187d593da57646190f5268cfae5ead00a9e40b",
        urls = ["https://github.com/GoogleContainerTools/distroless/archive/aa187d593da57646190f5268cfae5ead00a9e40b.tar.gz"],
    )

    maybe(
        http_archive,
        name = "io_bazel_rules_docker",
        sha256 = "14ac30773fdb393ddec90e158c9ec7ebb3f8a4fd533ec2abbfd8789ad81a284b",
        strip_prefix = "rules_docker-0.12.1",
        urls = ["https://github.com/bazelbuild/rules_docker/releases/download/v0.12.1/rules_docker-v0.12.1.tar.gz"],
    )

    maybe(
        http_archive,
        name = "rules_python",
        sha256 = "aa96a691d3a8177f3215b14b0edc9641787abaaa30363a080165d06ab65e1161",
        url = "https://github.com/bazelbuild/rules_python/releases/download/0.0.1/rules_python-0.0.1.tar.gz",
    )

    maybe(
        http_archive,
        name = "io_bazel_rules_go",
        sha256 = "842ec0e6b4fbfdd3de6150b61af92901eeb73681fd4d185746644c338f51d4c0",
        urls = [
            "https://storage.googleapis.com/bazel-mirror/github.com/bazelbuild/rules_go/releases/download/v0.20.1/rules_go-v0.20.1.tar.gz",
            "https://github.com/bazelbuild/rules_go/releases/download/v0.20.1/rules_go-v0.20.1.tar.gz",
        ],
    )

    maybe(
        http_archive,
        name = "bazel_gazelle",
        sha256 = "41bff2a0b32b02f20c227d234aa25ef3783998e5453f7eade929704dcff7cd4b",
        urls = [
            "https://storage.googleapis.com/bazel-mirror/github.com/bazelbuild/bazel-gazelle/releases/download/v0.19.0/bazel-gazelle-v0.19.0.tar.gz",
            "https://github.com/bazelbuild/bazel-gazelle/releases/download/v0.19.0/bazel-gazelle-v0.19.0.tar.gz",
        ],
    )

    maybe(
        http_archive,
        name = "subpar",
        sha256 = "34bb4dadd86bbdd3b5736952167e20a1a4c27ff739de11532c4ef77c7c6a68d9",
        strip_prefix = "subpar-35bb9f0092f71ea56b742a520602da9b3638a24f",
        urls = ["https://github.com/google/subpar/archive/35bb9f0092f71ea56b742a520602da9b3638a24f.tar.gz"],
    )

    maybe(
        http_file,
        name = "busybox",
        executable = True,
        sha256 = "b51b9328eb4e60748912e1c1867954a5cf7e9d5294781cae59ce225ed110523c",
        urls = ["https://busybox.net/downloads/binaries/1.27.1-i686/busybox"],
    )

    maybe(
        native.bind,
        name = "busybox_tar",
        actual = "@com_github_aputs_bazel_tools//runtime/images/busybox:busybox.tar",
    )