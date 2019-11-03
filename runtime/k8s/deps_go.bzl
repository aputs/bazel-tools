load("//:maybe.bzl", "maybe")
load("@bazel_gazelle//:deps.bzl", "gazelle_dependencies", "go_repository")
load("@io_bazel_rules_docker//repositories:go_repositories.bzl", rules_docker_go_deps = "go_deps")

def setup_k8s_go_dependencies():
    rules_docker_go_deps()

    maybe(
        go_repository,
        name = "com_github_google_go_cmp",
        importpath = "github.com/google/go-cmp",
        sum = "h1:Xye71clBPdm5HgqGwUkwhbynsUJZhDbS20FvLhQ2izg=",
        version = "v0.3.1",
    )
