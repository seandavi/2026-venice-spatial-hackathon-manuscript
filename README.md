# Bioconductor Spatial Data and Image Analysis Hackathon — Preprint

Quarto source for the Venice (April 2026) hackathon preprint.

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
└── participants.md          source-of-truth author table (from Drive sheet)
```

## Render

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
- Citations are BibTeX keys: `[@cui2024scgpt]`. Some Team 1, 3, and 4
  citations were stubbed (`@petukhov2024mousecolon`, `@colon2025`,
  `@anndataR2025`, `@sosta2025`, `@imageTCGA`, etc.) and should be
  fleshed out with full author lists / titles before submission.
- Two figure placeholders remain in `sections/05-interoperability.qmd`
  (`@fig-spatialdata-overview` and `@fig-spatialdataplot-images`) — these
  need the actual PNGs from the SpatialData team.
- `figures/team_analysis/analysis_fig1.png` is referenced but not yet
  present (the team supplied a `.pptx` slide that needs to be exported).
