# rules_python fixups for python3

## Setup and usage via Bazel

`WORKSPACE` file:
```bzl
load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")

http_archive(
    name = "com_github_aputs_bazel_tools",
    strip_prefix = "bazel-tools-<commit hash>",
    urls = ["https://github.com/aputs/bazel-tools/archive/<commit hash>.tar.gz"],
)

```

`BUILD.bazel` file:
```bzl
load(
    "@com_github_aputs_bazel_tools//python:pip.bzl",
    "setup_pip_dependencies",
    py3_pip_import = "pip_import",
)

setup_pip_dependencies()

py3_pip_import(
    name = "pip_py_deps",
    requirements = "<location to>:requirements.txt",
)

load("@pip_py_deps//:requirements.bzl", pip_pip_install = "pip_install")

pip_pip_install()
```

Test with:
```bash
bazel build @pip_deps//:requirements.bzl
```

`Update tools/`

All of the content (except BUILD) under tools/ is generated. To update the documentation simply run this in the root of the repository:

```bash
./update_tools.sh
```
