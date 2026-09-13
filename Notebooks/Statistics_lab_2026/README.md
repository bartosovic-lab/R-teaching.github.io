# Statistics lab: revised notebooks

Open [index.html](index.html) for the student route. The superseded statistics notebooks are preserved on the repository’s `main` branch and have been removed from this deployment branch.

- Six student guides/reference notebooks have editable `.Rmd` sources and rendered HTML in `notebooks/`.
- `Statistics_lab.Rproj` opens the portable workshop project. Keep student copies in `notebooks/`.
- `statistics_lab_student.zip` contains the student project without instructor answers or source archives.
- `data/dictionary.html` describes the observations, measurement scales, and provenance.
- `instructor/guide.md` covers pacing, implementation choices, and verification.
- `instructor/solutions.html` contains worked feedback and numerical reference results.
- `instructor/review.md` records the teaching review and suggestions for the next run.
- `instructor/planning/` preserves the agreed course design and original goals/lecture transcript as planning inputs.

The day 2 blank template renders successfully before completion but does not run a group test or correlation until the student chooses methods. A successful Knit alone is therefore not evidence of a completed assignment; the final checklist requires actual results and explanations.

## Publish the student download

The setup guide links to the student ZIP on branch `course/statistics-lab-2026` in `bartosovic-lab/R-teaching.github.io`. That link becomes available only after the branch and its commits are pushed:

```sh
git push -u origin course/statistics-lab-2026
```

Publishing this branch makes its files downloadable without merging into `main`. It does not by itself change the repository's GitHub Pages deployment. Keep the branch available while distributing this URL; update the setup links if the course later moves to a different branch.

## Rebuild

From this project folder:

```sh
python3 scripts/prepare_data.py
Rscript scripts/render.R
python3 scripts/package_students.py
```

Rendering requires R, `rmarkdown`, `knitr`, and Pandoc. Building the instructor's violin figure additionally requires `ggplot2`; students receive the figure and do not need that package. RStudio supplies Pandoc. If running outside RStudio, set `RSTUDIO_PANDOC` to its Pandoc directory or put Pandoc on PATH. No package installation or downloads occur during rendering.

Each document is rendered in a separate R process. Validation exercises every allowed day 2 method/variable combination and checks preparation against the preserved source files. See `instructor/validation.md` for the results of this build.
