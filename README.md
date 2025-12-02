# Blog Articles & Examples

This repository holds long-form articles together with the accompanying Rust and Python code examples. Each article lives in `articles/<slug>/` and can be rendered to a printable PDF with Pandoc. Code lives under `code/<language>/<slug>/` and is kept runnable through unit tests.

## Structure

```
articles/
  demo-post/
    assets/          # Images and other media referenced by the article
    index.md         # Primary Markdown manuscript
code/
  rust/
    demo-post/       # Stand-alone Cargo crate for the article
  python/
    demo-post/       # Stand-alone pytest-enabled project
docs/                # Generated PDFs
scripts/             # Helper scripts for rendering and testing
```

## Prerequisites

- [Pandoc](https://pandoc.org/) for PDF generation.
- LaTeX distribution (e.g., TeX Live) if you plan to customize PDF typesetting.
- Rust toolchain (`cargo`) for Rust examples.
- Python 3.10+ with `pytest` for Python examples.

### Fedora quick start

```bash
sudo dnf install pandoc
sudo dnf install texlive-scheme-full   # or a slimmer texlive collection if you prefer
```

## Usage

Render a single article to PDF:

```bash
scripts/render_article.sh articles/demo-post/index.md
```

Render every article in the repository:

```bash
scripts/render_all.sh
```

Run all example tests:

```bash
scripts/check_examples.sh
```

Use these commands as references when adding new articles—copy the `demo-post` layout, update the Markdown and code, and keep examples verified with the helper scripts.
