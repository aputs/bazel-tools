load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")

def setup_k8s_dependencies():
    _maybe(
        http_archive,
        name = "containerregistry",
        sha256 = "44e6db83cdf3514ad5c2c099803eaa53acadec9e12dc0735ae836063d7011c5e",
        strip_prefix = "containerregistry-c05873486625d452f7dc36ce718e1310a65cd2f1",
        urls = ["https://github.com/c4urself/containerregistry/archive/c05873486625d452f7dc36ce718e1310a65cd2f1.tar.gz"],
    )

def _maybe(repo_rule, name, **kwargs):
    if name not in native.existing_rules():
        repo_rule(name = name, **kwargs)
