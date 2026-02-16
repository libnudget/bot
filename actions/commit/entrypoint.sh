#!/usr/bin/env bash
set -e

MESSAGE="$1"

if [ -z "$MESSAGE" ]; then
  echo "❌ Commit message is required"
  exit 1
fi

git config user.name "libnudget[bot]"
git config user.email "libnudget@users.noreply.github.com"

git status --porcelain
git commit -am "$MESSAGE"
