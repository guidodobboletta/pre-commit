#!/bin/bash

set -e

# OSX GUI apps do not pick up environment variables the same way as Terminal apps and there are no easy solutions,
# especially as Apple changes the GUI app behavior every release (see https://stackoverflow.com/q/135688/483528). As a
# workaround to allow GitHub Desktop to work, add this (hopefully harmless) setting here.
export PATH=$PATH:/usr/local/bin

for dir in $(echo "$@" | xargs -n1 dirname | sort -u | uniq); do
  pushd "$dir" >/dev/null
  # rm -rf ".terraform" >/dev/null
  echo "Current directory being checked: $dir"
  export AWS_DEFAULT_REGION=us-west-2
  terraform init -backend=false
  terraform validate
  unset AWS_DEFAULT_REGION
  popd >/dev/null
done
