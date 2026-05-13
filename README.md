# Bioconductor Spatial Data and Image Analysis Hackathon — Preprint

Quarto source for the Venice (April 2026) hackathon preprint.

## Rendered versions

Every push to `main` and every pull request is rendered to HTML and PDF by
[`.github/workflows/render.yml`](.github/workflows/render.yml) and published to
the `gh-pages` branch. The URL pattern is stable across the lifetime of the
repository:

| What | URL |
|------|-----|
| Latest main (HTML) | `https://seandavi.github.io/2026-venice-spatial-hackathon-manuscript/` |
| Latest main (PDF)  | `https://seandavi.github.io/2026-venice-spatial-hackathon-manuscript/manuscript.pdf` |
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
├── references.bib           BibTeX, includes Team 2 + new entries for the rest
├── participants.md          source-of-truth author table (from Drive sheet)
└── .github/workflows/       CI: render and publish on push/PR
```

## Render locally

```bash
quarto render                    # all formats (HTML, PDF, DOCX)
quarto render --to html
quarto render --to pdf
quarto preview                   # live HTML preview while editing
```

PDF rendering requires a TeX install (TinyTeX is fine: `quarto install tinytex`).

## Authorship

Author order follows the manuscript byline convention:

1. **Helena Crowell** (lead, corresponding)
2. **Luca Marconato** (lead)
3. All other participants alphabetically by surname
4. **Wolfgang Huber** (senior)
5. **Davide Risso** (senior, corresponding)

Affiliations are referenced by ID in the `index.qmd` frontmatter so that
each unique institution is listed once.

## Editing notes

- Each team owns one `sections/0X-*.qmd`. Keep PR scope inside that file
  where possible.
- Cross-references use Quarto syntax: `@fig-id`, `@tbl-id`, `@sec-id`.
- Citations are BibTeX keys: `[@cui2024scgpt]`. Several entries are still
  stubs — see [issue #4](https://github.com/seandavi/2026-venice-spatial-hackathon-manuscript/issues/4).
- Two figure placeholders remain in `sections/05-interoperability.qmd`
  (`@fig-spatialdata-overview` and `@fig-spatialdataplot-images`) — see
  [issues #2](https://github.com/seandavi/2026-venice-spatial-hackathon-manuscript/issues/2)
  and [#3](https://github.com/seandavi/2026-venice-spatial-hackathon-manuscript/issues/3).
- `figures/team_analysis/analysis_fig1.png` is referenced but not yet
  present (the team supplied a `.pptx` slide that needs to be exported) —
  see [issue #1](https://github.com/seandavi/2026-venice-spatial-hackathon-manuscript/issues/1).
