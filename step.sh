#!/bin/bash
# fail if any commands fails
set -e
DEV_EMAIL="$GIT_CLONE_COMMIT_AUTHOR_EMAIL"
if [[ -z $DEV_SLACK ]]; then
  DEV_EMAIL="$GIT_CLONE_COMMIT_AUTHOR_EMAIL"
fi
envman add --key DEV_EMAIL  --value "$DEV_EMAIL"
DEV_SLACK="$DEV_EMAIL"
if [ -f .slackmap ] && [[ ! -z $DEV_SLACK ]]; then
  DEV_SLACK=$(echo $DEV_SLACK | tr -d '"')
  DEV_SLACK=$(grep -E "^$DEV_SLACK = " .slackmap | awk -F" = " '{print $2}')
  if [[ -z $DEV_SLACK ]]; then
    DEV_SLACK="$DEV_EMAIL"
  else
    DEV_SLACK="@$DEV_SLACK"
  fi
fi
echo "DEV_SLACK = $DEV_SLACK"
envman add --key DEV_SLACK  --value "$DEV_SLACK"
