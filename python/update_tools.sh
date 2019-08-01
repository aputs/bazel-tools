#!/bin/bash

set -euo pipefail

bazel_bin_path=$(bazel info bazel-bin)
repo_path=$(dirname ${BASH_SOURCE[0]})
bazel build //python:piptool.par //python:whltool.par
cp ${bazel_bin_path}/python/piptool.par ${repo_path}/tools/piptool.par
cp ${bazel_bin_path}/python/whltool.par ${repo_path}/tools/whltool.par