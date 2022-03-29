#!/usr/bin/env bash

git fetch --tags

latest_tag=$(git describe --tags `git rev-list --tags --max-count=1`)

local_version=$(grep -o '".*"' mlp_wfp_kf/version.py | tr -d '"')

function version { echo "$@" | awk -F. '{ printf("%d%03d%03d%03d\n", $1,$2,$3,$4); }'; }

if [ $(version $latest_tag) -gt $(version $local_version) ]; then
    echo "Aborting commit: local version, $local_version, is behind latest tag, $latest_tag."
	exit 1
fi
