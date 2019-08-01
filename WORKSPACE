workspace(name = "com_github_aputs_bazel_tools")

load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")

http_archive(
    name = "rules_python",
    sha256 = "dbc4786e038c6fb61f4899c3671b0ee4086b9c48a8ede6fbb430c1518b3b53ad",
    strip_prefix = "rules_python-120590e2f2b66e5590bf4dc8ebef9c5338984775",
    urls = ["https://github.com/bazelbuild/rules_python/archive/120590e2f2b66e5590bf4dc8ebef9c5338984775.tar.gz"],
)

load("@rules_python//python:pip.bzl", "pip_repositories")

pip_repositories()

load("@rules_python//python:pip.bzl", "pip_import")

pip_import(
    name = "piptool_deps",
    requirements = "@rules_python//python:requirements.txt",
)

load(
    "@piptool_deps//:requirements.bzl",
    _piptool_install = "pip_install",
)

_piptool_install()

http_archive(
    name = "subpar",
    sha256 = "34bb4dadd86bbdd3b5736952167e20a1a4c27ff739de11532c4ef77c7c6a68d9",
    strip_prefix = "subpar-35bb9f0092f71ea56b742a520602da9b3638a24f",
    urls = ["https://github.com/google/subpar/archive/35bb9f0092f71ea56b742a520602da9b3638a24f.tar.gz"],
)