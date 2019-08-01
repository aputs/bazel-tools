# google related tools

Bazel rule to `bazel run` multiple executable targets sequentially.

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
load("@com_github_aputs_bazel_tools//:google/gcs.bzl", "gcs_file")

gcs_file(
    name = "filename_wsp",
    bucket = "gs://<gcs bucket name>",
    file = "<filename inside gcs bucket>",
    downloaded_file_path = "<output filename>",
    sha256 = "<sha256 for the downloaded file>",
)

```
Test with
```bash
bazel build @filename_wsp//file:<downloaded_file_path>
```