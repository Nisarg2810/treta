#!/bin/zsh
# Build a copy pointed at https://treta-derma.pages.dev and deploy it to Cloudflare Pages.
set -e
OUT=$(mktemp -d)
rsync -a --exclude .git --exclude __pycache__ "$(dirname $0)/" "$OUT/"
(cd "$OUT" && BASE="https://treta-derma.pages.dev/" python3 build.py && rm -rf build.py v2_home.py __pycache__ README.md .gitignore .nojekyll deploy-cf.sh)
npx --yes wrangler@3 pages deploy "$OUT" --project-name treta-derma --branch main --commit-dirty=true
rm -rf "$OUT"
