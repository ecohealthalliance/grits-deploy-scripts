#!/bin/bash
cd ~/grits-api
# create a config file
sudo tee config.py <<EOF
aws_access_key = '$CLASSIFIER_DATA_ACCESS_KEY'
aws_secret_key = '$CLASSIFIER_DATA_SECRET_KEY'
BROKER_URL = '$CELERY_BROKER'
mongo_url = '$MONGO_URL'
bing_translate_id = '$BING_TRANSLATE_ID'
bing_translate_secret = '$BING_TRANSLATE_SECRET'
api_key = '$GRITS_API_KEY'
EOF

virtualenv grits_api_env
. grits_api_env/bin/activate
pip install -r requirements.txt
if [ "$IMPORT_GEONAMES" = "true" ]; then
    # Import geonames for the location extractor
    cd annie
    ./import_geonames.sh
    cd ..
fi
# This script does the rest. Rerun it to update when the code changes.
./deploy.sh
