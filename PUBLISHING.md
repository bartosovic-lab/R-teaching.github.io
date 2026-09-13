# Publish the updated course without merging the branches

The repository keeps two branches:

- `main`: the previous course, preserved unchanged by this update.
- `course/statistics-lab-2026`: the revised course and current site navigation.

The new root `index.md` leads to the revised workshop. `Pages/KN7001.md` also links to the revised notebooks. The superseded `Notebooks/Statistics_lab/` directory is removed from the new branch. Its old live URLs will no longer be served after the deployment switch; the complete previous course remains on `main`. Receptor–ligand and transcriptomics courses remain available.

## One-time Pages setting

A repository admin or maintainer must open:

[Repository Settings → Pages](https://github.com/bartosovic-lab/R-teaching.github.io/settings/pages)

Under **Build and deployment**, use:

- Source: **Deploy from a branch**
- Branch: **course/statistics-lab-2026**
- Folder: **/(root)**

Click **Save** and wait for the `pages-build-deployment` workflow to finish. The site address remains:

https://bartosovic-lab.github.io/R-teaching.github.io/

The account used to prepare this change has write access, but GitHub reports neither admin nor maintainer access. Pushing the branch alone does not change the Pages source. GitHub requires admin or maintainer permissions to configure it; see [the publishing-source documentation](https://docs.github.com/en/pages/getting-started-with-github-pages/configuring-a-publishing-source-for-your-github-pages-site).

## Subsequent updates

Work on `course/statistics-lab-2026`, regenerate affected HTML and the student ZIP, commit, then push. Once that branch is selected as the publishing source, pushes update the live site. The repository's default branch can remain `main`.

Check the deployed homepage, KN7001 navigation, each workshop HTML link, and the ZIP download after the first deployment. The build must finish before new URLs become available. `_config.yml` excludes instructor answers, planning inputs, preparation scripts, and output folders from the Pages site. They remain in the public Git repository; this exclusion is organisation of teaching material, not access control.

To return the site to the previous course, an admin or maintainer can select `main` and `/(root)` again. No branch deletion, force push, or history rewrite is needed.
