load("//:maybe.bzl", "maybe")
load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")

def setup_k8s_dependencies():
    maybe(
        http_archive,
        name = "io_bazel_rules_k8s",
        sha256 = "a34539941fd920432b7c545f720129e2f2e6b2285f1beb66de25e429f91759bf",
        strip_prefix = "rules_k8s-0.3",
        urls = ["https://github.com/bazelbuild/rules_k8s/releases/download/v0.3/rules_k8s-v0.3.tar.gz"],
    )

    maybe(
        http_archive,
        name = "com_github_yaml_pyyaml",
        build_file_content = """
py_library(
    name = "yaml",
    srcs = glob(["lib/yaml/*.py"]),
    imports = [
        "lib",
    ],
    visibility = ["//visibility:public"],
)
py_library(
    name = "yaml3",
    srcs = glob(["lib3/yaml/*.py"]),
    imports = [
        "lib3",
    ],
    visibility = ["//visibility:public"],
)
""",
        sha256 = "e9df8412ddabc9c21b4437ee138875b95ebb32c25f07f962439e16005152e00e",
        strip_prefix = "pyyaml-5.1.2",
        urls = ["https://github.com/yaml/pyyaml/archive/5.1.2.zip"],
    )