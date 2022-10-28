#!/bin/bash
OUTPUT=$(echo '{}' | jq '{
          "event_type": "$EVENT_TYPE",
          "client_payload": {
            "build_num": "$CIRCLE_BUILD_NUM",
            "branch": "$CIRCLE_BRANCH",
            "username": "$CIRCLE_USERNAME",
            "job": "$CIRCLE_JOB",
            "build_url": "$CIRCLE_BUILD_URL",
            "vcs_revision": "$CIRCLE_SHA1",
            "reponame": "$CIRCLE_PROJECT_REPONAME",
            "workflow_id": "$CIRCLE_WORKFLOW_ID",
            "pull_request": "$CI_PULL_REQUEST",
            "metadata": "$METADATA",
          }
        }' | curl -X POST -H "Content-Type:application/json" -H "Accept:application/vnd.github.v3+json" -H "Authorization: token $GH_TOKEN" -d @- "https://api.github.com/repos/$REPO_NAME/dispatches")
echo "$OUTPUT"
touch /tmp/output.txt
echo "$OUTPUT" > /tmp/output.txt
