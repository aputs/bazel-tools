load("@io_bazel_rules_docker//python3:image.bzl", "py3_image")

py_binary(
    name = "py3_only",
    srcs = ["py3_only.py"],
    python_version = "PY3",
)

py3_image(
    name = "_py3_only",
    srcs = ["py3_only.py"],
    base = "@com_github_aputs_bazel_tools//runtime/images/python3",
    main = "py3_only.py",
)

