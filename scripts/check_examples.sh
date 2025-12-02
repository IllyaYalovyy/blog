#!/usr/bin/env bash
set -euo pipefail

repo_root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

if command -v cargo >/dev/null 2>&1; then
  shopt -s nullglob
  rust_manifests=("$repo_root"/code/rust/*/Cargo.toml)
  shopt -u nullglob

  for manifest in "${rust_manifests[@]}"; do
    crate_dir="$(dirname "$manifest")"
    echo "Running cargo test in $crate_dir"
    (cd "$crate_dir" && cargo test)
  done
else
  echo "cargo not found; skipping Rust examples" >&2
fi

if command -v pytest >/dev/null 2>&1; then
  shopt -s nullglob
  python_projects=("$repo_root"/code/python/*/pyproject.toml)
  shopt -u nullglob

  for project in "${python_projects[@]}"; do
    project_dir="$(dirname "$project")"
    echo "Running pytest in $project_dir"
    (cd "$project_dir" && pytest)
  done
else
  echo "pytest not found; skipping Python examples" >&2
fi
