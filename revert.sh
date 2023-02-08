#!/bin/bash
set -e

if [ -z "$1" ]
then 
  echo input is empty! 
  exit -1
fi

echo $1
# get the SHA to revert
COMMIT_TO_REVERT=$1

REPO_FULLNAME=$(jq -r ".repository.full_name" "$GITHUB_EVENT_PATH")
echo "Collecting information about PR #$PR_NUMBER of $REPO_FULLNAME..."

if [[ -z "$GITHUB_TOKEN" ]]; then
	echo "Set the GITHUB_TOKEN env variable."
	exit 1
fi

echo $REPO_FULLNAME

HEAD_BRANCH="main"

git remote set-url origin https://x-access-token:$GITHUB_TOKEN@github.com/$REPO_FULLNAME.git
git config --global user.email "AdamNJG@github.com"
git config --global user.name "ANJG auto revert"

set -o xtrace

git pull origin $HEAD_BRANCH
git revert $COMMIT_TO_REVERT --no-edit
git push origin $HEAD_BRANCH