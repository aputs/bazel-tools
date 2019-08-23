package(default_visibility = ["//visibility:public"])

licenses(["notice"])

load("@subpar//:subpar.bzl", "par_binary")

par_binary(
    name = "resolver",
    srcs = ["resolver.py"],
    main = "resolver.py",
    deps = [
        "@containerregistry",
    ],
)
