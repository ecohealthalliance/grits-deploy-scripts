#!/bin/bash
# Configure it with your account details:
mkdir ~/.aws
tee ~/.aws/config <<EOF
[default]
region = us-east-1
aws_access_key_id = $GIRDER_DATA_ACCESS_KEY
aws_secret_access_key = $GIRDER_DATA_SECRET_KEY
EOF
# To download the database dump from S3:
aws s3 cp --recursive s3://girder-data/dump dump
mongorestore
