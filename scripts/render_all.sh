#!/usr/bin/env bash
set -euo pipefail

repo_root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
script_dir="$repo_root/scripts"
render_script="$script_dir/render_article.sh"

shopt -s nullglob
articles=("$repo_root"/articles/*/index.md)
shopt -u nullglob

if [[ ${#articles[@]} -eq 0 ]]; then
  echo "No articles found under $repo_root/articles" >&2
  exit 0
fi

for article in "${articles[@]}"; do
  "$render_script" "$article"
done
