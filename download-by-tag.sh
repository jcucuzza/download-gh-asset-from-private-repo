#!/bin/bash

# This script overcomes the challenges of programmatically downloading an asset from a private
# repository hosted on GitHub.
# Download an asset by providing this script with a pat token, owner, repository,
# tag, and the asset name as arguments.
#
# PREREQUISITES
#
#       curl, jq
# USAGE
#       ./download.sh <github-pat-token> <operating-system> <release>
#
# EXAMPLE
#       ./download.sh ghp_01910eafb31c72fb9c72ad4afcb0z jcucuzza myapps-repo 1.0.0 my-asset-to-download
#

GITHUB_API_TOKEN=$1
OWNER=$2
REPO=$3
TAG=$4
ASSET_TO_DOWNLOAD=$5

GH_API="https://api.github.com/"
GH_REPO="$GH_API/repos/$OWNER/$REPO"
GH_LATEST="$GH_REPO/releases/tags/$TAG"
AUTH="Authorization: token $GITHUB_API_TOKEN"
ACCEPT="Accept: application/vnd.github+json"

response=$(curl -s -H "$AUTH" -H "$ACCEPT" $GH_LATEST | jq .)
for asset in $(echo $response | jq -r '.assets[] | @base64'); do
    _jq() {
        echo ${1} | base64 --decode | jq -r ${2}
    }

    name=$(_jq $asset '.name')
    if [[ $name == $ASSET_TO_DOWNLOAD ]]; then
        id=$(_jq $asset '.id')
        GH_ASSET="$GH_REPO/releases/assets/$id"
        curl -v -L -o "$name" -H "$AUTH" -H 'Accept: application/octet-stream' "$GH_ASSET"
    fi

done