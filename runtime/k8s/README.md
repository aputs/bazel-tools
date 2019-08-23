# fix for rule_k8s py3 compat

## Setup and usage via Bazel

`WORKSPACE` file:
```bzl
load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")

http_archive(
    name = "com_github_aputs_bazel_tools",
    strip_prefix = "bazel-tools-<commit hash>",
    urls = ["https://github.com/aputs/bazel-tools/archive/<commit hash>.tar.gz"],
)

# this must preceed rules_docker initialization
load("@com_github_aputs_bazel_tools//runtime/k8s:deps.bzl", "setup_k8s_dependencies")

setup_k8s_dependencies()

load("@containerregistry//:def.bzl", setup_containerregistry_repositories = "repositories")

setup_containerregistry_repositories()
```

```use @com_github_aputs_bazel_tools//runtime/k8s:resolver.par to replace rules_k8s default resolver```
