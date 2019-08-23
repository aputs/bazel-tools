workspace(name = "com_github_aputs_bazel_tools")

load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive", "http_file")

## python3

http_archive(
    name = "subpar",
    sha256 = "34bb4dadd86bbdd3b5736952167e20a1a4c27ff739de11532c4ef77c7c6a68d9",
    strip_prefix = "subpar-35bb9f0092f71ea56b742a520602da9b3638a24f",
    urls = ["https://github.com/google/subpar/archive/35bb9f0092f71ea56b742a520602da9b3638a24f.tar.gz"],
)

load("//python:pip.bzl", "setup_pip_dependencies")

setup_pip_dependencies()

load("@rules_python//python:pip.bzl", "pip_import", "pip_repositories")

pip_repositories()

pip_import(
    name = "piptool_deps",
    requirements = "@rules_python//python:requirements.txt",
)

load(
    "@piptool_deps//:requirements.bzl",
    _piptool_install = "pip_install",
)

_piptool_install()

## runtime

load("//runtime:deps.bzl", "setup_runtime_dependencies")

setup_runtime_dependencies()

load("//runtime/k8s:deps.bzl", "setup_k8s_dependencies")

setup_k8s_dependencies()

load("@containerregistry//:def.bzl", setup_containerregistry_repositories = "repositories")

setup_containerregistry_repositories()

load(
    "@io_bazel_rules_docker//repositories:repositories.bzl",
    container_repositories = "repositories",
)

container_repositories()

load("@io_bazel_rules_docker//repositories:deps.bzl", container_deps = "deps")

container_deps()

register_toolchains("@io_bazel_rules_docker//toolchains/python:container_py_toolchain")

load(
    "@distroless//package_manager:package_manager.bzl",
    "package_manager_repositories",
)

package_manager_repositories()

load("//runtime:buster.bzl", "setup_package_bundle_dependencies")

setup_package_bundle_dependencies()
