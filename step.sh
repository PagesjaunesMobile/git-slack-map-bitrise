#!/bin/bash
# fail if any commands fails
set -e
# debug log
set -x
SLACK_NAME=$(grep "$GIT_CLONE_COMMIT_AUTHOR_EMAIL" .slack-names | awk -F" = " '{print $2}')
echo "SLACK : $SLACK_NAME"
envman add --key GIT_CLONE_COMMIT_AUTHOR_SLACK  --value "$SLACK_NAME"