package(default_visibility = ["//visibility:public"])

licenses(["notice"])

load("@io_bazel_rules_docker//container:container.bzl", "container_image")
load("@package_bundle//file:packages.bzl", "packages")

[container_image(
    name = "ldap" if (not mode) else mode[1:],
    base = "//runtime/images/cc" + mode,
    debs = [
        packages["libdb5.3"],
        packages["libffi6"],
        packages["libgmp10"],
        packages["libgnutls30"],
        packages["libhogweed4"],
        packages["libidn2-0"],
        packages["libldap-2.4-2"],
        packages["libltdl7"],
        packages["libnettle6"],
        packages["libodbc1"],
        packages["libp11-kit0"],
        packages["libsasl2-2"],
        packages["libtasn1-6"],
        packages["libunistring2"],
        packages["libwrap0"],
        packages["slapd"],
        packages["zlib1g"],
    ],
    entrypoint = [
        "/usr/sbin/slapd",
    ],
) for mode in [
    "",
    ":debug",
]]
