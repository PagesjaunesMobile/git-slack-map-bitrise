#!/bin/bash
# fail if any commands fails
set -e
if [ -f .slackmap ] && [[ ! -z $GIT_CLONE_COMMIT_AUTHOR_EMAIL ]]; then
  GIT_CLONE_COMMIT_AUTHOR_EMAIL=$(echo $GIT_CLONE_COMMIT_AUTHOR_EMAIL | tr -d '"')
  SLACK_NAME=$(grep -E "^$GIT_CLONE_COMMIT_AUTHOR_EMAIL = " .slackmap | awk -F" = " '{print $2}')
  if [[ -z $SLACK_NAME ]]; then
    SLACK_NAME="$GIT_CLONE_COMMIT_AUTHOR_EMAIL"
  else
    SLACK_NAME="@$SLACK_NAME"
  fi
  
  echo "SLACK_NAME = $SLACK_NAME"
  envman add --key GIT_CLONE_COMMIT_AUTHOR_SLACK  --value "$SLACK_NAME"
fi
