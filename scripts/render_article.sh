#!/usr/bin/env bash
set -euo pipefail

if [[ $# -ne 1 ]]; then
  echo "Usage: $(basename "$0") <path-to-article-md>" >&2
  exit 1
fi

repo_root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
article_input="$1"

if [[ ! -f "$article_input" ]]; then
  echo "Error: article not found at '$article_input'" >&2
  exit 1
fi

article_abs="$(cd "$(dirname "$article_input")" && pwd)/$(basename "$article_input")"
article_dir="$(dirname "$article_abs")"
article_slug="$(basename "$article_dir")"
output_dir="$repo_root/docs"
mkdir -p "$output_dir"

pandoc "$article_abs" \
  --from markdown+yaml_metadata_block \
  --resource-path="$article_dir" \
  --output "$output_dir/${article_slug}.pdf"

echo "Rendered $article_abs -> $output_dir/${article_slug}.pdf"
