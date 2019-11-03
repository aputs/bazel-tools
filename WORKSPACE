workspace(name = "com_github_aputs_bazel_tools")

load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive", "http_file")
load("@com_github_aputs_bazel_tools//runtime:deps.bzl", "setup_runtime_dependencies")

setup_runtime_dependencies()

load("@com_github_aputs_bazel_tools//runtime:buster.bzl", "setup_package_bundle_dependencies")

setup_package_bundle_dependencies()

load("@com_github_aputs_bazel_tools//runtime:container.bzl", "setup_container_dependencies")

setup_container_dependencies()

load("@com_github_aputs_bazel_tools//runtime:container_image.bzl", "setup_container_image_dependencies")

setup_container_image_dependencies()

load("@com_github_aputs_bazel_tools//runtime/k8s:deps.bzl", "setup_k8s_dependencies")

setup_k8s_dependencies()

load("@com_github_aputs_bazel_tools//runtime/k8s:deps_go.bzl", "setup_k8s_go_dependencies")

setup_k8s_go_dependencies()

load("@io_bazel_rules_docker//python3:image.bzl", py3_container_image_repositories = "repositories")

py3_container_image_repositories()

load("@com_github_aputs_bazel_tools//python:pip.bzl", "setup_pip_dependencies", py3_pip_import = "pip_import")

setup_pip_dependencies()

py3_pip_import(
    name = "piptool_deps",
    requirements = "//python:requirements.txt",
)

load("@piptool_deps//:requirements.bzl", _piptool_install = "pip_install")

_piptool_install()
