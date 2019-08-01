package(default_visibility = ["//visibility:public"])

licenses(["notice"])

load("@subpar//:subpar.bzl", "par_binary")
load("@piptool_deps//:requirements.bzl", "requirement")

py_library(
    name = "whl",
    srcs = ["whl.py"],
    deps = [
        requirement("setuptools"),
    ],
)

par_binary(
    name = "piptool",
    srcs = ["piptool.py"],
    deps = [
        ":whl",
        requirement("pip"),
        requirement("wheel"),
    ],
)

par_binary(
    name = "whltool",
    srcs = ["whl.py"],
    main = "whl.py",
    deps = [
        ":whl",
    ],
)
