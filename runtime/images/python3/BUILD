package(default_visibility = ["//visibility:public"])

licenses(["notice"])

load("@io_bazel_rules_docker//container:container.bzl", "container_image")
load("@package_bundle//file:packages.bzl", "packages")

[container_image(
    name = "python3" if (not mode) else mode[1:],
    base = "//runtime/images/cc" + mode,
    debs = [
        packages["dash"],
        packages["zlib1g"],
        packages["python3.7-minimal"],
        packages["python3-distutils"],
        packages["python3-setuptools"],
        packages["libpython3.7-minimal"],
        packages["libpython3.7-stdlib"],
        packages["libexpat1"],
        packages["libffi6"],
        packages["libsqlite3-0"],

        # packages["libbz2-1.0"],
        # packages["liblzma5"],

        # packages["libtinfo5"],
        # packages["libncursesw5"]
        # packages["libreadline7"],
    ],
    entrypoint = [
        "/usr/bin/python3",
    ],
    env = {
        "PYTHONUNBUFFERED": "1",
    },
    symlinks = {
        "/bin/sh": "/bin/dash",
        "/usr/bin/python": "/usr/bin/python3.7",
        "/usr/bin/python3": "/usr/bin/python3.7",
    },
) for mode in [
    "",
    ":debug",
]]
