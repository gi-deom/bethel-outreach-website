**Deploying the site (GitHub Pages)**

- Build and deploy (recommended):

```sh
npm run deploy
```

- What the script does:
  - Runs `npm run build` to create `dist/`.
  - Uses `git worktree` to create a temporary worktree for the `gh-pages` branch.
  - Copies `dist/` contents into the worktree, commits, and pushes to `gh-pages`.

- Notes:
  - If `gh-pages` does not exist, the script creates it.
  - The script is idempotent and safe to re-run.

If you prefer a manual deploy, you can also run:

```sh
npm run build
# then push dist/ to gh-pages (example method)
git checkout --orphan gh-pages
git rm -rf .
cp -r dist/* .
git add --all && git commit -m "Deploy: publish dist to gh-pages"
git push -f origin gh-pages
git checkout main
```
