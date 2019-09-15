#!/bin/bash

set -euo pipefail

bazel_bin_path=$(bazel info bazel-bin)
repo_path=$(dirname ${BASH_SOURCE[0]})
bazel build //runtime/k8s:stamper.par
cp ${bazel_bin_path}/runtime/k8s/stamper.par ${repo_path}/stamper.par