load("//:maybe.bzl", "maybe")
load("@distroless//package_manager:package_manager.bzl", "package_manager_repositories")
load("@distroless//package_manager:dpkg.bzl", "dpkg_list", "dpkg_src")

PACKAGE_BUNDLE_PACKAGES = [
    "base-files",
    "ca-certificates",
    "dash",
    "dumb-init",
    "gzip",
    "libbz2-1.0",
    "libc-bin",
    "libc6",
    "libcom-err2",
    "libdb5.3",
    "libexpat1",
    "libffi6",
    "libgcc1",
    "libgmp10",
    "libgnutls30",
    "libgomp1",
    "libgssapi-krb5-2",
    "libglib2.0-0",
    "libhogweed4",
    "libidn11",
    "libidn2-0",
    "libk5crypto3",
    "libkeyutils1",
    "libkrb5-3",
    "libkrb5support0",
    "libldap-2.4-2",
    "libltdl7",
    "liblzma5",
    "libncursesw5",
    "libnettle6",
    "libodbc1",
    "libp11-kit0",
    "libpq5",
    "libpcre3",
    "libpython2.7-minimal",
    "libpython2.7-stdlib",
    "libpython3.7-minimal",
    "libpython3.7-stdlib",
    "libreadline7",
    "libsasl2-2",
    "libsqlite3-0",
    "libssl1.1",
    "libstdc++6",
    "libtasn1-6",
    "libtinfo5",
    "libunistring2",
    "libwrap0",
    "mime-support",
    "netbase",
    "openssl",
    "python2.7-minimal",
    "python3.7-minimal",
    "python3-distutils",
    "python3-setuptools",
    "python3-pkg-resources",
    "python3-ldap3",
    "python3-psycopg2",
    "readline-common",
    "slapd",
    "tzdata",
    "zlib1g",
]

def setup_package_bundle_dependencies():
    package_manager_repositories()

    maybe(
        dpkg_src,
        name = "debian_buster",
        arch = "amd64",
        distro = "buster",
        sha256 = "ca19e4187523f4b087a2e7aaa2662c6a0b46dc81ff2f3dd44d9c5d95df0df212",
        snapshot = "20191104T030405Z",
        url = "https://snapshot.debian.org/archive",
    )

    maybe(
        dpkg_src,
        name = "debian_buster_security",
        package_prefix = "https://snapshot.debian.org/archive/debian-security/20191104T030405Z/",
        packages_gz_url = "https://snapshot.debian.org/archive/debian-security/20191104T030405Z/dists/buster/updates/main/binary-amd64/Packages.gz",
        sha256 = "40b58aa0aae0e7bd0ed2314a09b58c0a392d8231286a5e3839d8b2a7d1bbba4e",
    )

    maybe(
        dpkg_list,
        name = "package_bundle",
        packages = PACKAGE_BUNDLE_PACKAGES,
        sources = [
            "@debian_buster_security//file:Packages.json",
            "@debian_buster//file:Packages.json",
        ],
    )
