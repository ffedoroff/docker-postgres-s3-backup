#!/bin/bash
set -e

#
# main entry point to run s3cmd
#

#
# Check for required parameters
#
if [ -z "${AWS_KEY}" ]; then
    echo "ERROR: The environment variable key is not set."
    exit 1
fi

if [ -z "${AWS_SECERT}" ]; then
    echo "ERROR: The environment variable secret is not set."
    exit 1
fi

#
# Add key and secret in the /.s3cfg file with the one the user provided
#
cp /.s3cfg ~/.s3cfg
echo "access_key=${AWS_KEY}" >> ~/.s3cfg
echo "secret_key=${AWS_SECERT}" >> ~/.s3cfg
