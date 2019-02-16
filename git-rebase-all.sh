#!/bin/bash
set -x

# 'use strict';
set -eou pipefail

# Refuse to switch if there's a diff.
if git ls-files -d -m | grep -q . ; then
   exit 1
fi

echo 'No files seem changed; continuing.'

# Switch to master at the start & end, for sanity.
git fetch origin
git remote prune origin
git checkout master
git rebase origin/master || git rebase --abort

for branch in $(git show-ref --heads | grep -v master | awk '{print $2}' | sed s,refs/heads/,, )
do
    git checkout "$branch" >/dev/null 2>&1

    # If the branch has no remote tracking branch, rebase it against
    # origin/master.
    BRANCH="$(git for-each-ref --format='%(upstream:short)'  refs/heads/$branch)"
    if [ ! -z "$BRANCH" ] && git show-ref "$BRANCH" > /dev/null; then
        # Rebase it against its remote tracking branch.
        git pull --rebase || git rebase --abort
    else
        git rebase origin/master || git rebase --abort
    fi
done

git checkout master