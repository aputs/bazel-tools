package(default_visibility = ["//visibility:public"])

licenses(["notice"])

load("@io_bazel_rules_docker//container:container.bzl", "container_image")
load("@package_bundle//file:packages.bzl", "packages")

[container_image(
    name = "with_pg" if (not mode) else mode[1:],
    base = "//runtime/images/python3" + mode,
    debs = [
        packages["libcom-err2"],
        packages["libgmp10"],
        packages["libgnutls30"],
        packages["libgssapi-krb5-2"],
        packages["libhogweed4"],
        packages["libidn11"],
        packages["libidn2-0"],
        packages["libk5crypto3"],
        packages["libkeyutils1"],
        packages["libkrb5-3"],
        packages["libkrb5support0"],
        packages["libldap-2.4-2"],
        packages["libnettle6"],
        packages["libp11-kit0"],
        packages["libpq5"],
        packages["libunistring2"],
        packages["libsasl2-2"],
        packages["libtasn1-6"],
        packages["python3-ldap3"],
        packages["python3-psycopg2"],
    ],
) for mode in [
    "",
    ":debug",
]]