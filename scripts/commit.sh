#!/usr/bin/env bash
set -e

if [ -z "$1" ]; then
  echo "Usage: ./commit.sh \"message\""
  exit 1
fi

./scripts/configure-git.sh
git commit -am "$1"
