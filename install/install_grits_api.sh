#!/bin/bash
cd ~
git clone https://$GIT_USER:$GIT_PASSWORD@github.com/ecohealthalliance/grits-api.git
cd ~/grits-api
# create a config file
cp config.sample.py config.py
virtualenv grits_api_env
grits_api_env/bin/pip install -r requirements.txt
# Import geonames for the location extractor
./import_geonames.sh
# This script does the rest. Rerun it to update when the code changes.
./deploy.sh
