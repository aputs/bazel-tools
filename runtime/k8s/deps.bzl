load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")

def setup_k8s_dependencies():
    _maybe(
        http_archive,
        name = "containerregistry",
        sha256 = "44e6db83cdf3514ad5c2c099803eaa53acadec9e12dc0735ae836063d7011c5e",
        strip_prefix = "containerregistry-c05873486625d452f7dc36ce718e1310a65cd2f1",
        urls = ["https://github.com/c4urself/containerregistry/archive/c05873486625d452f7dc36ce718e1310a65cd2f1.tar.gz"],
    )

    _maybe(
        http_archive,
        name = "com_github_yaml_pyyaml",
        build_file_content = """
# TODO fix for py2/py3
py_library(
    name = "yaml",
    srcs = glob(["lib3/yaml/*.py"]),
    imports = [
        "lib3",
    ],
    visibility = ["//visibility:public"],
)""",
        sha256 = "d4154501a7081e7ca11120f3b0141d14e9c1c146364d62f2cf8efe7724390d66",
        strip_prefix = "pyyaml-3.13",
        urls = ["https://github.com/yaml/pyyaml/archive/3.13.zip"],
    )

    # for containerregistry
    _maybe(
        http_archive,
        name = "httplib2_py2_3",
        url = "https://codeload.github.com/httplib2/httplib2/tar.gz/v0.11.3",
        sha256 = "d9f568c183d1230f271e9c60bd99f3f2b67637c3478c9068fea29f7cca3d911f",
        strip_prefix = "httplib2-0.11.3",
        type = "tar.gz",
        build_file_content = """
py_library(
    name = "httplib2",
    srcs = glob(["**/*.py"]),
    data = [
        "python2/httplib2/cacerts.txt",
        "python3/httplib2/cacerts.txt",
    ],
   visibility = ["//visibility:public"]
)""",
    )

    # Used by oauth2client
    _maybe(
        http_archive,
        name = "six",
        url = "https://pypi.python.org/packages/source/s/six/six-1.9.0.tar.gz",
        sha256 = "e24052411fc4fbd1f672635537c3fc2330d9481b18c0317695b46259512c91d5",
        strip_prefix = "six-1.9.0/",
        type = "tar.gz",
        build_file_content = """
# Rename six.py to __init__.py
genrule(
    name = "rename",
    srcs = ["six.py"],
    outs = ["__init__.py"],
    cmd = "cat $< >$@",
)
py_library(
   name = "six",
   srcs = [":__init__.py"],
   visibility = ["//visibility:public"],
)""",
    )

    # Used for authentication in containerregistry
    _maybe(
        http_archive,
        name = "oauth2client",
        url = "https://codeload.github.com/google/oauth2client/tar.gz/v4.0.0",
        sha256 = "7230f52f7f1d4566a3f9c3aeb5ffe2ed80302843ce5605853bee1f08098ede46",
        strip_prefix = "oauth2client-4.0.0/oauth2client/",
        type = "tar.gz",
        build_file_content = """
py_library(
   name = "oauth2client",
   srcs = glob(["**/*.py"]),
   visibility = ["//visibility:public"],
   deps = [
     "@containerregistry//httplib2:httplib2",
     "@six//:six",
   ]
)""",
    )

    # Used for parallel execution in containerregistry
    _maybe(
        http_archive,
        name = "rules_python",
        sha256 = "b5bab4c47e863e0fbb77df4a40c45ca85f98f5a2826939181585644c9f31b97b",
        strip_prefix = "rules_python-9d68f24659e8ce8b736590ba1e4418af06ec2552",
        urls = ["https://github.com/bazelbuild/rules_python/archive/9d68f24659e8ce8b736590ba1e4418af06ec2552.tar.gz"],
    )

def _maybe(repo_rule, name, **kwargs):
    if name not in native.existing_rules():
        repo_rule(name = name, **kwargs)
