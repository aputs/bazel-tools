load("//:maybe.bzl", "maybe")
load("@io_bazel_rules_go//go:deps.bzl", "go_register_toolchains", "go_rules_dependencies")
load("@bazel_gazelle//:deps.bzl", "gazelle_dependencies", "go_repository")
load("@rules_python//python:repositories.bzl", rules_python_repositories = "py_repositories")
load("@io_bazel_rules_docker//repositories:repositories.bzl", rules_docker_repositories = "repositories")

def setup_container_dependencies():
    go_rules_dependencies()
    go_register_toolchains()
    gazelle_dependencies()

    rules_python_repositories()

    maybe(
        go_repository,
        name = "com_github_google_go_containerregistry",
        commit = "68bc585818eeca751a710d0f83265e3966a0f56c",
        importpath = "github.com/google/go-containerregistry",
    )

    maybe(
        go_repository,
        name = "com_github_pkg_errors",
        commit = "27936f6d90f9c8e1145f11ed52ffffbfdb9e0af7",
        importpath = "github.com/pkg/errors",
    )

    maybe(
        go_repository,
        name = "in_gopkg_yaml_v2",
        commit = "f221b8435cfb71e54062f6c6e99e9ade30b124d5",  # v2.2.4
        importpath = "gopkg.in/yaml.v2",
    )

    maybe(
        go_repository,
        name = "com_github_kylelemons_godebug",
        commit = "9ff306d4fbead574800b66369df5b6144732d58e",  # v1.1.0
        importpath = "github.com/kylelemons/godebug",
    )

    maybe(
        go_repository,
        name = "com_github_ghodss_yaml",
        importpath = "github.com/ghodss/yaml",
        sum = "h1:wQHKEahhL6wmXdzwWG11gIVCkOv05bNOh+Rxn0yngAk=",
        version = "v1.0.0",
    )

    rules_docker_repositories()
