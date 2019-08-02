package(default_visibility = ["//visibility:public"])

licenses(["notice"])

load("@io_bazel_rules_docker//container:container.bzl", "container_image")
load("@package_bundle//file:packages.bzl", "packages")

[container_image(
    name = "python3" if (not mode) else mode[1:],
    base = "//runtime/images/cc" + mode,
    debs = [
        packages["libbz2-1.0"],
        packages["libc-bin"],
        packages["libexpat1"],
        packages["libffi6"],
        packages["liblzma5"],
        packages["libncursesw5"],
        packages["libpython3.7-minimal"],
        packages["libpython3.7-stdlib"],
        packages["libreadline7"],
        packages["libsqlite3-0"],
        packages["libssl1.1"],
        packages["libtinfo5"],
        packages["python3.7-minimal"],
        packages["zlib1g"],
    ],
    entrypoint = [
        "/usr/bin/python3.7",
    ],
    env = {
        "PYTHONUNBUFFERED": "1",
    },
    symlinks = {
        "/usr/bin/python": "/usr/bin/python3.7",
        "/usr/bin/python3": "/usr/bin/python3.7",
    },
    tars = [
        "@distroless//experimental/python2.7:ld_so_cache.tar",
    ],
) for mode in [
    "",
    ":debug",
]]
