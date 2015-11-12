#!/bin/bash
set -e

#
# main entry point to run s3cmd
#

#
# Check for required parameters
#
if [ -z "${aws_key}" ]; then
    echo "ERROR: The environment variable key is not set."
    exit 1
fi

if [ -z "${aws_secret}" ]; then
    echo "ERROR: The environment variable secret is not set."
    exit 1
fi

#
# Add key and secret in the /.s3cfg file with the one the user provided
#
cp /.s3cfg ~/.s3cfg
echo "access_key=${aws_key}" >> ~/.s3cfg
echo "secret_key=${aws_secret}" >> ~/.s3cfg
