# Bioconductor Spatial Data and Image Analysis Hackathon — Preprint

[![Render manuscript](https://github.com/seandavi/2026-venice-spatial-hackathon-manuscript/actions/workflows/render.yml/badge.svg)](https://github.com/seandavi/2026-venice-spatial-hackathon-manuscript/actions/workflows/render.yml)
[![HTML](https://img.shields.io/badge/manuscript-HTML-1D76DB?logo=html5&logoColor=white)](https://seandavi.github.io/2026-venice-spatial-hackathon-manuscript/)
[![PDF](https://img.shields.io/badge/manuscript-PDF-D32F2F?logo=adobeacrobatreader&logoColor=white)](https://seandavi.github.io/2026-venice-spatial-hackathon-manuscript/manuscript.pdf)

Quarto source for the Venice (April 2026) hackathon preprint.

## Rendered versions

Every push to `main` and every pull request is rendered to HTML and PDF by
[`.github/workflows/render.yml`](.github/workflows/render.yml) and published to
the `gh-pages` branch. The URL pattern is stable across the lifetime of the
repository:

| What | URL |
|------|-----|
| Latest main (HTML) | <https://seandavi.github.io/2026-venice-spatial-hackathon-manuscript/> |
| Latest main (PDF)  | <https://seandavi.github.io/2026-venice-spatial-hackathon-manuscript/manuscript.pdf> |
| Specific commit (HTML) | `…/v/<commit-sha>/` |
| Specific commit (PDF)  | `…/v/<commit-sha>/manuscript.pdf` |
| Open PR preview        | `…/pr/<pr-number>/` |

`/v/<sha>/` snapshots are immutable — link to those when sharing a specific
revision (e.g., for a co-author review or external comment). The `/` and
`/manuscript.pdf` endpoints always point to the most recent main build.

When a PR is opened, the workflow comments on it with the preview links, so
reviewers can read the rendered version without checking out the branch.

## Layout

```
.
├── _quarto.yml              project + format config
├── index.qmd                title, authors, abstract, affiliations, includes
├── sections/
│   ├── 01-introduction.qmd
│   ├── 02-image-analysis.qmd
│   ├── 03-foundation-models.qmd
│   ├── 04-stratified-de.qmd
│   ├── 05-interoperability.qmd
│   └── 06-discussion.qmd
├── figures/                 figures, organized by team
│   ├── team_image-analysis/
│   ├── team_foundationmodels/
│   ├── team_analysis/
│   └── team_interoperability/
├── references.bib           BibTeX bibliography
├── participants.md          source-of-truth author table (from Drive sheet)
└── .github/workflows/       CI: render and publish on push/PR
```

## Contributing

The intended workflow is **branch → edit → preview → PR**. CI publishes
PR-specific previews so reviewers don't need a local Quarto install.

### Section ownership

Each team owns one section file. Keep PR scope inside that file where
possible to minimize cross-team merge conflicts.

| Section | File | Owner / writer |
|--------|------|---------------|
| Introduction | `sections/01-introduction.qmd` | Organizers (HC, LM, WH, DR) |
| Image and segmentation | `sections/02-image-analysis.qmd` | Team 1 |
| Foundation models | `sections/03-foundation-models.qmd` | Team 2 |
| Stratified DE | `sections/04-stratified-de.qmd` | Team 3 |
| Interoperability | `sections/05-interoperability.qmd` | Team 4 |
| Discussion | `sections/06-discussion.qmd` | Organizers + writers |

### Make a change

```bash
git switch -c yourname/short-description           # branch off main
# … edit your section .qmd, drop figures into figures/team_<name>/, …
quarto preview                                     # live HTML preview at localhost:4444
git add sections/0X-yoursection.qmd figures/...
git commit -m "Section X: rewrite results paragraph"
git push -u origin yourname/short-description
gh pr create --fill                                # or use the github UI
```

The render workflow will build your branch, post a sticky comment on the
PR with HTML + PDF preview links, and update those links on every push to
the branch.

### Authoring conventions

- **Cross-references**: `@fig-id`, `@tbl-id`, `@sec-id`. Define them inline:
  `![…](path){#fig-id}`, `: caption {#tbl-id}`, or `## Section {#sec-id}`.
- **Citations**: BibTeX keys, `[@cui2024scgpt]` for parenthetical or
  `@cui2024scgpt` for narrative. Add entries to `references.bib` —
  Crossref, DOI lookups, and Zotero export all produce compatible output.
- **Figures**: drop new figures under `figures/team_<your-team>/` and
  reference them from your section as `figures/team_<your-team>/foo.png`
  (project-root-relative; do **not** prefix with `../`).
- **Authorship**: do not edit the author list directly in `index.qmd`
  unless adding a missing affiliation or fixing an ORCID. The byline
  follows the convention in the [Authorship](#authorship) section below.
- **Voice**: aim for journal methods voice, not hackathon-internal
  shorthand. Spell out package names on first use; link to GitHub repos
  for software described.

### Render locally (optional)

CI renders on every push, so a local install isn't required for reviewing
prose. If you want a local feedback loop:

```bash
quarto render                  # full project, all formats
quarto render --to html        # HTML only (fast)
quarto render --to pdf         # PDF (needs TeX)
quarto preview                 # live-reload HTML at localhost:4444
```

PDF rendering requires a TeX install. The simplest is TinyTeX:

```bash
quarto install tinytex
```

### Open issues to pick from

Rather than start from scratch, see [open issues](https://github.com/seandavi/2026-venice-spatial-hackathon-manuscript/issues).
Current high-leverage tasks:

- [#1](https://github.com/seandavi/2026-venice-spatial-hackathon-manuscript/issues/1) Export Team 3 Figure 1 from PowerPoint
- [#2](https://github.com/seandavi/2026-venice-spatial-hackathon-manuscript/issues/2), [#3](https://github.com/seandavi/2026-venice-spatial-hackathon-manuscript/issues/3) Get SpatialData figures from Team 4
- [#4](https://github.com/seandavi/2026-venice-spatial-hackathon-manuscript/issues/4) Complete bibliography stub entries
- [#5](https://github.com/seandavi/2026-venice-spatial-hackathon-manuscript/issues/5) Smooth voice and style across team sections
- [#6](https://github.com/seandavi/2026-venice-spatial-hackathon-manuscript/issues/6) Add per-author contributions detail
- [#9](https://github.com/seandavi/2026-venice-spatial-hackathon-manuscript/issues/9) Re-fetch corrupted features_pca.png

## Authorship

Author order follows the manuscript byline convention:

1. **Helena Crowell** (lead, corresponding)
2. **Luca Marconato** (lead)
3. All other participants alphabetically by surname
4. **Wolfgang Huber** (senior)
5. **Davide Risso** (senior, corresponding)

Affiliations are referenced by ID in the `index.qmd` frontmatter so that
each unique institution is listed once. The full participant roster with
ORCIDs, affiliations, and COI declarations is in [`participants.md`](participants.md).

## Drafting tools

This preprint was drafted collaboratively with help from
[quartobot](https://github.com/quartobot/quartobot), a small Quarto
companion CLI. quartobot ships an MCP server that exposes its
DOI / PMID / arXiv citation resolver to coding agents, which made it
straightforward to look up references and extend `references.bib`
inline while writing — without round-tripping through Crossref or
PubMed by hand. The render pipeline itself is plain Quarto; nothing in
this repo requires quartobot to build. See the manuscript's
[Use of AI tools](index.qmd) section for the broader acknowledgment.
