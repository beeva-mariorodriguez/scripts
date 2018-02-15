#!/bin/bash

readonly local code=$1
readonly local tmpdir="${HOME}/Private"
readonly local outjson="${tmpdir}/out.json"

aws sts assume-role --role-arn "${AWS_ROLE_ARN}" \
                    --profile "${AWS_PROFILE}" \
                    --serial-number "${AWS_MFA_ARN}" \
                    --role-session-name "${AWS_SESSION_NAME}" \
                    --token-code "${code}" > "${outjson}"

if [ $? != 0 ]
then
    echo "error"
else
    AWS_ACCESS_KEY_ID=$(jq .Credentials.AccessKeyId < "${outjson}")
    AWS_SESSION_TOKEN=$(jq .Credentials.SessionToken < "${outjson}")
    AWS_SECRET_ACCESS_KEY=$(jq .Credentials.SecretAccessKey < "${outjson}")
    echo export AWS_ACCESS_KEY_ID="$AWS_ACCESS_KEY_ID"
    echo export AWS_SESSION_TOKEN="$AWS_SESSION_TOKEN"
    echo export AWS_SECRET_ACCESS_KEY="$AWS_SECRET_ACCESS_KEY"
fi

