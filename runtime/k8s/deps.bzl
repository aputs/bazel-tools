load("//:maybe.bzl", "maybe")
load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")

def setup_k8s_dependencies():
    maybe(
        http_archive,
        name = "io_bazel_rules_k8s",
        sha256 = "a34539941fd920432b7c545f720129e2f2e6b2285f1beb66de25e429f91759bf",
        strip_prefix = "rules_k8s-0.3",
        urls = ["https://github.com/bazelbuild/rules_k8s/releases/download/v0.3/rules_k8s-v0.3.tar.gz"],
    )

#     maybe(
#         http_archive,
#         name = "containerregistry",
#         sha256 = "ae64548f4e59515ced48f649f82b5e0ef17343e0386f43da99acc081a7610703",
#         strip_prefix = "containerregistry-da03b395ccdc4e149e34fbb540483efce962dc64",
#         urls = ["https://github.com/aputs/containerregistry/archive/da03b395ccdc4e149e34fbb540483efce962dc64.tar.gz"],
#     )

#     maybe(
#         http_archive,
#         name = "com_github_yaml_pyyaml",
#         build_file_content = """
# # forced py3
# py_library(
#     name = "yaml",
#     srcs = glob(["lib3/yaml/*.py"]),
#     imports = [
#         "lib3",
#     ],
#     visibility = ["//visibility:public"],
# )""",
#         sha256 = "e9df8412ddabc9c21b4437ee138875b95ebb32c25f07f962439e16005152e00e",
#         strip_prefix = "pyyaml-5.1.2",
#         urls = ["https://github.com/yaml/pyyaml/archive/5.1.2.zip"],
#     )

#     maybe(
#         http_archive,
#         name = "httplib2_py2_3",
#         url = "https://codeload.github.com/httplib2/httplib2/tar.gz/v0.11.3",
#         sha256 = "d9f568c183d1230f271e9c60bd99f3f2b67637c3478c9068fea29f7cca3d911f",
#         strip_prefix = "httplib2-0.11.3",
#         type = "tar.gz",
#         build_file_content = """
# py_library(
#     name = "httplib2",
#     srcs = glob(["**/*.py"]),
#     data = [
#         "python2/httplib2/cacerts.txt",
#         "python3/httplib2/cacerts.txt",
#     ],
#    visibility = ["//visibility:public"]
# )""",
#     )

#     maybe(
#         http_archive,
#         name = "six",
#         url = "https://pypi.python.org/packages/source/s/six/six-1.9.0.tar.gz",
#         sha256 = "e24052411fc4fbd1f672635537c3fc2330d9481b18c0317695b46259512c91d5",
#         strip_prefix = "six-1.9.0/",
#         type = "tar.gz",
#         build_file_content = """
# # Rename six.py to __init__.py
# genrule(
#     name = "rename",
#     srcs = ["six.py"],
#     outs = ["__init__.py"],
#     cmd = "cat $< >$@",
# )
# py_library(
#    name = "six",
#    srcs = [":__init__.py"],
#    visibility = ["//visibility:public"],
# )""",
#     )

#     maybe(
#         http_archive,
#         name = "oauth2client",
#         url = "https://codeload.github.com/google/oauth2client/tar.gz/v4.0.0",
#         sha256 = "7230f52f7f1d4566a3f9c3aeb5ffe2ed80302843ce5605853bee1f08098ede46",
#         strip_prefix = "oauth2client-4.0.0/oauth2client/",
#         type = "tar.gz",
#         build_file_content = """
# py_library(
#    name = "oauth2client",
#    srcs = glob(["**/*.py"]),
#    visibility = ["//visibility:public"],
#    deps = [
#      "@containerregistry//httplib2:httplib2",
#      "@six//:six",
#    ]
# )""",
#     )