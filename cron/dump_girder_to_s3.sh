#!/bin/bash
mongodump --db girder
aws s3 cp --recursive dump s3://girder-data/dump
echo "dump completed on `date`"
