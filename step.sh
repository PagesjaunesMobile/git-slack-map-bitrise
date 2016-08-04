#!/bin/bash
# fail if any commands fails
set -e
if [ -f .slack-names ] && [[ ! -z $GIT_CLONE_COMMIT_AUTHOR_EMAIL ]]; then
  SLACK_NAME=$(grep -E "^$GIT_CLONE_COMMIT_AUTHOR_EMAIL = " .slack-names | awk -F" = " '{print $2}')
  SLACK_NAME=$(echo $SLACK_NAME | tr -d '"')
  if [[ -z $SLACK_NAME ]]; then
    SLACK_NAME="Slack name not found for user $GIT_CLONE_COMMIT_AUTHOR_EMAIL"
  fi
  envman add --key GIT_CLONE_COMMIT_AUTHOR_SLACK  --value "$SLACK_NAME"
fi