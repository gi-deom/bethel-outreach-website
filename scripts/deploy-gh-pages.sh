#!/usr/bin/env sh
set -e

# Deploy built site to gh-pages branch using git worktree.
# Safe to run repeatedly from the project root.

BRANCH=gh-pages
WORKTREE_DIR=".gh-pages-temp"

echo "Building site..."
npm run build

echo "Preparing worktree..."
if git ls-remote --exit-code --heads origin $BRANCH >/dev/null 2>&1; then
  git worktree add -B $BRANCH $WORKTREE_DIR origin/$BRANCH
else
  git worktree add -b $BRANCH $WORKTREE_DIR
fi

echo "Copying files to worktree..."
rm -rf "$WORKTREE_DIR"/*
cp -r dist/* "$WORKTREE_DIR"/

cd "$WORKTREE_DIR"
git add --all
if git commit -m "Deploy: publish dist to gh-pages" ; then
  echo "Committed deploy to worktree"
else
  echo "No changes to deploy"
fi
echo "Pushing to origin/$BRANCH..."
git push origin $BRANCH
cd - >/dev/null

echo "Cleaning up worktree..."
git worktree remove "$WORKTREE_DIR" || true

echo "Deployment complete. Site should be live at: https://$(git config --get remote.origin.url | sed 's/.*github.com[:/]\(.*\)\.git/\1/')/"
