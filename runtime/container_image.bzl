load("//:maybe.bzl", "maybe")
load("@io_bazel_rules_docker//container:container.bzl", "container_pull")

_REGISTRY = "l.gcr.io"

def setup_container_image_dependencies():
    maybe(
        container_pull,
        name = "bazel_latest",
        registry = _REGISTRY,
        repository = "google/bazel",
        tag = "latest",
    )
