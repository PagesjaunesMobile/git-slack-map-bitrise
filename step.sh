#!/bin/bash
# fail if any commands fails
set -e
DEV_SLACK="$GIT_CLONE_COMMIT_AUTHOR_EMAIL"
if [[ -z $DEV_SLACK ]]; then
  DEV_SLACK="$GIT_CLONE_COMMIT_AUTHOR_EMAIL"
fi
envman add --key DEV_EMAIL  --value "$DEV_SLACK"
if [ -f .slackmap ] && [[ ! -z $GIT_CLONE_COMMIT_AUTHOR_EMAIL ]]; then
  GIT_CLONE_COMMIT_AUTHOR_EMAIL=$(echo $GIT_CLONE_COMMIT_AUTHOR_EMAIL | tr -d '"')
  DEV_SLACK=$(grep -E "^$GIT_CLONE_COMMIT_AUTHOR_EMAIL = " .slackmap | awk -F" = " '{print $2}')
  if [[ -z $DEV_SLACK ]]; then
    DEV_SLACK="$GIT_CLONE_COMMIT_AUTHOR_EMAIL"
  else
    DEV_SLACK="@$DEV_SLACK"
  fi
fi
echo "DEV_SLACK = $DEV_SLACK"
envman add --key DEV_SLACK  --value "$DEV_SLACK"
