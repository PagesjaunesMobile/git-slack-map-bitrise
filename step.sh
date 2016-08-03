#!/bin/bash
# fail if any commands fails
set -e
if [ -f .slack-names ]; then
  SLACK_NAME=$(grep "$GIT_CLONE_COMMIT_AUTHOR_EMAIL" .slack-names | awk -F" = " '{print $2}')
  envman add --key GIT_CLONE_COMMIT_AUTHOR_SLACK  --value "$SLACK_NAME"
fi