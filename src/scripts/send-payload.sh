#!/bin/bash
echo '{}' | jq '{
          "event_type":"<<parameters.event_type>>",
          "client_payload": {
            "build_num": env.CIRCLE_BUILD_NUM,
            "branch": env.CIRCLE_BRANCH,
            "username": env.CIRCLE_USERNAME,
            "job": env.CIRCLE_JOB,
            "build_url": env.CIRCLE_BUILD_URL,
            "vcs_revision": env.CIRCLE_SHA1,
            "reponame": env.CIRCLE_PROJECT_REPONAME,
            "workflow_id": env.CIRCLE_WORKFLOW_ID,
            "pull_request": env.CI_PULL_REQUEST,
          },
          "metadata": <<parameters.metadata>>
        }' | curl -X POST -H "Content-Type:application/json" -H "Accept:application/vnd.github.v3+json" -H "Authorization: token $<<parameters.github_personal_access_token>>" -d @- "https://api.github.com/repos/<<parameters.repo_name>>/dispatches"