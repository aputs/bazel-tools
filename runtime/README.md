# curated images using distroless build

## Setup and usage via Bazel

`WORKSPACE` file:
```bzl
load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")

http_archive(
    name = "com_github_aputs_bazel_tools",
    strip_prefix = "bazel-tools-<commit hash>",
    urls = ["https://github.com/aputs/bazel-tools/archive/<commit hash>.tar.gz"],
)

load("@com_github_aputs_bazel_tools//runtime:deps.bzl", "setup_runtime_dependencies")

setup_runtime_dependencies()

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

load("@com_github_aputs_bazel_tools//runtime:buster.bzl", "setup_package_bundle_dependencies")

setup_package_bundle_dependencies()

```

`BUILD.bazel` file:
```bzl

load("@io_bazel_rules_docker//python3:image.bzl", "py3_image")

py3_image(
    name = "py3_image",
    base = "@com_github_aputs_bazel_tools//runtime/images/python3",
    ...
)
```
