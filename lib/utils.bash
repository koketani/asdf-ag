#!/usr/bin/env bash

set -euo pipefail

GH_REPO="https://github.com/ggreer/the_silver_searcher"
BUILD_REF="https://github.com/ggreer/the_silver_searcher#building-master"
TOOL_NAME="ag"
TOOL_CMD="ag"

fail() {
  echo -e "asdf-$TOOL_NAME: $*"
  exit 1
}

curl_opts=(-fsSL)

sort_versions() {
  sed 'h; s/[+-]/./g; s/.p\([[:digit:]]\)/.z\1/; s/$/.z/; G; s/\n/ /' |
    LC_ALL=C sort -t. -k 1,1 -k 2,2n -k 3,3n -k 4,4n -k 5,5n | awk '{print $2}'
}

list_github_tags() {
  git ls-remote --tags --refs "$GH_REPO" |
    grep -o 'refs/tags/.*' | cut -d/ -f3-
}

list_all_versions() {
  list_github_tags
}

install_version() {
  local version="$1"
  local install_path="$2"

  # Temporary directory to download and build the tool
  TMP_DOWNLOAD_DIR=$(mktemp -d -t ag_build_XXXXXX)
  echo "* Created a directory $TMP_DOWNLOAD_DIR to download and build the tool"
  cleanup() { rm -rf "$TMP_DOWNLOAD_DIR"; }
  trap cleanup ERR EXIT

  (
    # Download tar.gz file
    local release_file="$TMP_DOWNLOAD_DIR/$TOOL_NAME-${version}.tar.gz"
    local url="$GH_REPO/archive/refs/tags/${version}.tar.gz"
    echo "* Downloading $TOOL_NAME release $version..."
    curl "${curl_opts[@]}" -o "$release_file" -C - "$url" || fail "Could not download $url"

    # Extract contents of tar.gz file
    local download_path="$TMP_DOWNLOAD_DIR/${TOOL_NAME}-$version"
    mkdir -p "$download_path"
    echo "* Extracting $release_file..."
    tar -xzf "$release_file" -C "$download_path" --strip-components=1 || fail "Could not extract $release_file"

    # Build
    echo "* Building by using $download_path/build.sh..."
    "$download_path/build.sh" || fail "Could not build, please resolve in the first $BUILD_REF"

    # Install
    local binary_path="$install_path/bin"
    mkdir -p "$binary_path"
    mv "$download_path/ag" "$binary_path"
    test -x "$binary_path/$TOOL_CMD" || fail "Expected $binary_path/$TOOL_CMD to be executable."
    echo "* $TOOL_NAME $version installation was successful!"
  ) || (
    rm -rf "$install_path"
    fail "An error ocurred while installing $TOOL_NAME $version."
  )
}
