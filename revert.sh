#!/bin/bash
set -e

if [ -z "$1" ]
then 
  echo input is empty! 
  exit -1
fi

# get the SHA to revert
COMMIT_TO_REVERT=$1

REPO_FULLNAME=$(jq -r ".repository.full_name" "$GITHUB_EVENT_PATH")
echo "Collecting information about PR #$PR_NUMBER of $REPO_FULLNAME..."

if [[ -z "$GITHUB_TOKEN" ]]; then
	echo "Set the GITHUB_TOKEN env variable."
	exit 1
fi

echo $REPO_FULLNAME

URI=https://api.github.com
API_HEADER="Accept: application/vnd.github.v3+json"
AUTH_HEADER="Authorization: token $GITHUB_TOKEN"

pr_resp=$(curl -X GET -s -H "${AUTH_HEADER}" -H "${API_HEADER}" \
          "${URI}/repos/$REPO_FULLNAME/pulls/$PR_NUMBER")

HEAD_REPO=$(echo "$pr_resp" | jq -r .head.repo.full_name)
HEAD_BRANCH="MAIN"

git remote set-url origin https://x-access-token:$GITHUB_TOKEN@github.com/$REPO_FULLNAME.git
git config --global user.email "AdamNJG@github.com"
git config --global user.name "ANJG auto revert"

set -o xtrace

git fetch origin $HEAD_BRANCH

# do the revert
git checkout -b $HEAD_BRANCH origin/$HEAD_BRANCH

# check commit exists
git cat-file -t $COMMIT_TO_REVERT
git revert $COMMIT_TO_REVERT --no-edit
git push origin $HEAD_BRANCH