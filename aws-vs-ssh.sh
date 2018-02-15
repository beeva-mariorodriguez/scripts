#!/bin/bash

function check_auth {
    if ! aws ec2 describe-key-pairs --region=us-east-1 > /dev/null
    then
        echo "login to aws!"
        exit 1
    fi
}

function add_key {
    aws_regions=$(aws ec2 describe-regions --region us-east-1 | jq -r '.Regions[].RegionName')
    keyname="${1:-$USER}"
    privkey_path="${HOME}/.ssh/${KEYNAME}.aws"
    pubkey_path="${HOME}/.ssh/${KEYNAME}.aws.pub"
    ssh-keygen -f "${privkey_path}"
    for aws_region in $(echo $aws_regions)
    do
        aws ec2 import-key-pair --region "${aws_region}" --key-name "${keyname}" --public-key-material "$(cat ${pubkey_path})"
        echo "${keyname}" added to "${aws_region}"
    done
}

function del_key {
    aws_regions=$(aws ec2 describe-regions --region us-east-1 | jq -r '.Regions[].RegionName')
    keyname="${1:-$USER}"
    for aws_region in $(echo $aws_regions)
    do
        aws ec2 delete-key-pair --region "${aws_region}" --key-name "${keyname}"
        echo "${keyname}" deleted from "${aws_region}"
    done

}

case $1 in
    "add")
        check_auth
        add_key "$2"
        ;;
    "del")
        check_auth
        del_key "$2"
        ;;
    *)
        echo "$0 add|del [KEYNAME]"
        ;;
esac

