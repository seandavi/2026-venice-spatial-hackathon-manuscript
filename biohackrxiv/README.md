# BioHackrXiv preprint generation

This branch holds the [BioHackrXiv](https://biohackrxiv.org/) submission of the
manuscript and everything needed to reproduce its PDF. It is intended to be
**long-lived**: `main` carries the canonical Quarto manuscript, and this branch
carries the BioHackrXiv-specific derivatives (`paper.md`, `paper.bib`) plus the
reproducible build below.

## TL;DR

```bash
./biohackrxiv/build.sh    # needs docker + git; writes ./paper.pdf
```

## How BioHackrXiv builds the PDF

BioHackrXiv renders submissions with
[`biohackrxiv/bhxiv-gen-pdf`](https://github.com/biohackrxiv/bhxiv-gen-pdf): a
small Ruby wrapper around `pandoc` (pinned to 2.16.1) that reads `paper.md` +
`paper.bib` from a directory and typesets them with a fixed LaTeX template and
the APA CSL. The required YAML front-matter fields are `title`, `tags`,
`authors` (≥2), `group`, `date`, a bibliography (`bibliography` or
`cito-bibliography`), `event`, `authors_short`, plus `biohackathon_name`,
`biohackathon_url`, `biohackathon_location`, and `git_url`.

`build.sh` pins the tool to upstream commit
[`db1ed73`](https://github.com/biohackrxiv/bhxiv-gen-pdf/commit/db1ed730596fecb3b6544ab464460e803a23303e),
applies [`latex-template.patch`](latex-template.patch), builds the Docker image,
and runs `gen-pdf` against the repo root (so figure paths like `figures/...`
resolve).

## Files

| File | Purpose |
|------|---------|
| `paper.md` *(repo root)* | BioHackrXiv submission source. Contains the front-matter, body, and a **pre-rendered bibliography** baked in as pandoc CSL markup. |
| `paper.bib` *(repo root)* | Bibliography for the submission (a copy of `references.bib`). |
| `biohackrxiv/build.sh` | One-command reproducible build. |
| `biohackrxiv/latex-template.patch` | The two template fixes described below. |

## Three issues hit while reproducing, and their fixes

### 1. Apple Silicon: `exec format error` on pandoc

The upstream `Dockerfile` downloads an **amd64** pandoc binary. On an arm64 host
Docker builds an arm64 image by default, and the amd64 binary won't run.
**Fix:** build and run the image as `linux/amd64` (under emulation). Handled in
`build.sh` via `--platform=linux/amd64`.

### 2. Build failure: `! Undefined control sequence \CSLLeftMargin`

The template at this pinned commit defines the `CSLReferences` environment but
not the per-entry macros (`\CSLLeftMargin`, `\CSLRightInline`, `\CSLBlock`,
`\CSLIndent`) that pandoc 2.16's citeproc emits, so the LaTeX run aborts.
**Fix:** add the standard pandoc CSL macro definitions (first hunk of
`latex-template.patch`).

### 3. Reference titles ran together with no spaces

The template **redefines `\href`** so that any link to `https://doi.org/...` has
its *visible text* run through LaTeX's URL formatter (path-splitting, no spaces).
That is correct when the link text is a bare DOI, but the APA CSL emits
`\href{https://doi.org/...}{Full Article Title}` for a few entries — and those
titles came out as `Fullarticletitle...` overflowing the margin.
**Fix:** render `doi.org` links with the unmodified `\href` (second hunk of
`latex-template.patch`).

> Issues 2 and 3 are bugs in the public `bhxiv-gen-pdf` template, not in our
> source. They are patched here only so the PDF renders locally; they are worth
> reporting upstream so every submitter benefits.

## One fix that lives in the source (`paper.md`)

`paper.md` ships a **pre-rendered** reference list (generated when the Quarto
source was converted), in which DOIs are written as `doi:[10.x/...](https://doi.org/10.x/...)`.
`gen-pdf` runs pandoc with `--from markdown+autolink_bare_uris`, which treats the
leading `doi:` as a URI scheme and mangles the link into `doi:%5B10.x...]`.

Because BioHackrXiv regenerates the PDF from `paper.md` on their side, this one
**must** be fixed in the source rather than the toolchain. The fix moves `doi:`
inside the link text:

```
doi:[10.x/...](https://doi.org/10.x/...)   ->   [doi:10.x/...](https://doi.org/10.x/...)
```

Same DOI, same target, renders as a clean `doi:10.x/...` link, and no longer
trips `autolink_bare_uris`. Applied to all 12 occurrences in `paper.md`.

## Keeping this branch in sync with `main`

`main` does **not** contain `paper.md` / `paper.bib` (see `PREPRINT.md` there).
When pulling later changes from `main` into this branch, use a merge and keep
the BioHackrXiv files:

```bash
git checkout biohackrxiv
git merge main          # resolve by keeping paper.md / paper.bib if prompted
```
