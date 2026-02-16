#!/usr/bin/env bash
set -e

VERSION="$1"

if [ -z "$VERSION" ]; then
  echo "Usage: ./release.sh v1.0.0"
  exit 1
fi

./scripts/configure-git.sh
git tag -a "$VERSION" -m "release: $VERSION"
git push origin "$VERSION"
