load(
    "@distroless//package_manager:dpkg.bzl",
    "dpkg_list",
    "dpkg_src",
)

PACKAGE_BUNDLE_PACKAGES = [
    "base-files",
    "ca-certificates",
    "dash",
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
    "python3-ldap3",
    "python3-psycopg2",
    "readline-common",
    "slapd",
    "tzdata",
    "zlib1g",
]

def setup_package_bundle_dependencies():
    _maybe(
        dpkg_src,
        name = "debian_buster",
        arch = "amd64",
        distro = "buster",
        sha256 = "bd1bed6b19bf173d60ac130edee47087203e873f3b0981f5987f77a91a2cba85",
        snapshot = "20190731T041823Z",
        url = "https://snapshot.debian.org/archive",
    )

    _maybe(
        dpkg_src,
        name = "debian_buster_security",
        package_prefix = "https://snapshot.debian.org/archive/debian-security/20190730T203253Z/",
        packages_gz_url = "https://snapshot.debian.org/archive/debian-security/20190730T203253Z/dists/buster/updates/main/binary-amd64/Packages.gz",
        sha256 = "9ced04f06c2b4e1611d716927b19630c78fc7db604ba2cecebbb379cf6ba318b",
    )

    _maybe(
        dpkg_list,
        name = "package_bundle",
        packages = PACKAGE_BUNDLE_PACKAGES,
        sources = [
            "@debian_buster_security//file:Packages.json",
            "@debian_buster//file:Packages.json",
        ],
    )

def _maybe(repo_rule, name, **kwargs):
    if name not in native.existing_rules():
        repo_rule(name = name, **kwargs)
