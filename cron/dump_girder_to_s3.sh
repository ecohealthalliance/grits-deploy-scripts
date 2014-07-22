#!/bin/bash
rm -r dump
mongodump --db girder
aws s3 cp --recursive dump s3://girder-data/$S3_DUMP_DIRECTORY
echo "Girder to S3 dump completed on `date`"
