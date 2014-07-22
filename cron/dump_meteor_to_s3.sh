#!/bin/bash
rm -r dump
mongodump --db $METEOR_DB_NAME
aws s3 cp --recursive dump s3://girder-data/$S3_DUMP_DIRECTORY
echo "Meteor DB to S3 dump completed on `date`"
