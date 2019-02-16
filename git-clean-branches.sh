#!/bin/bash
set -x

# 'use strict';
set -eou pipefail

# Refuse to act if there's a diff.
if git ls-files -d -m | grep -q . ; then
   exit 1
fi

echo 'No files seem changed; continuing.'

# Switch to master at the start & end, for sanity.
git fetch origin
git checkout master
git rebase origin/master || git rebase --abort

# Remove historic remote tracking branches.
git remote prune origin

TO_REMOVE=""
for branch in $(git branch --merged | grep -v master )
do
    TRACKING_BRANCH="$(git config --get branch.$branch.merge || echo '')"
    TRACKING_BRANCH="${TRACKING_BRANCH:-refs/heads/master}"
    # If the branch has a remote tracking branch of master (or empty
    # string), and it is already merged origin/master, then throw it
    # away.
    if [ "${TRACKING_BRANCH}" = "refs/heads/master" ] ; then
        TO_REMOVE="$TO_REMOVE $branch"
    else
        echo "Ignoring branch $branch due to remote tracking branch ${TRACKING_BRANCH}."
    fi
done

git checkout master
for branch in $TO_REMOVE ; do
    git branch -d "$branch"
done