package(default_visibility = ["//visibility:public"])

licenses(["notice"])

exports_files([
    "resolve.sh.tpl",
])

load("@subpar//:subpar.bzl", "par_binary")

par_binary(
    name = "resolver",
    srcs = ["resolver.py"],
    main = "resolver.py",
    python_version = "PY3",
    deps = [
        "@com_github_yaml_pyyaml//:yaml",
        "@containerregistry",
    ],
)

par_binary(
    name = "stamper",
    srcs = ["stamper.py"],
    main = "stamper.py",
    python_version = "PY3",
    visibility = ["//visibility:public"],
)
