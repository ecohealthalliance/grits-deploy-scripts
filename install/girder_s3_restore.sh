#!/bin/bash
# The AWS CLI is a dependency for this script.
# Here's one way to install it: sudo pip install awscli
# Configure it with your account details:
mkdir ~/.aws
tee ~/.aws/config <<EOF
[default]
region = us-east-1
aws_access_key_id = $GIRDER_DATA_ACCESS_KEY
aws_secret_access_key = $GIRDER_DATA_SECRET_KEY
EOF
# To download the database dump from S3:
aws s3 cp --recursive s3://girder-data/$S3_MONGO_IMPORT_DIRECTORY dump
# Depending on the situation, you may want to add the --drop flag to remove
# data in the collections that does not exist in those you are restoring from.
mongorestore
