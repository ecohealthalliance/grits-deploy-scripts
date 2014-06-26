#!/bin/bash

# Install the AWS CLI as sudo so it is available in all environments.
sudo apt-get install -y python-pip
sudo pip install awscli
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
APACHE_URL=http://grits.ecohealth.io HEALTHMAP_APIKEY=$HEALTHMAP_APIKEY GIRDER_ADMIN_PASSWORD=password ./girder_setup.sh
# If you want to automatically backup the database use the following commands:
tee ~/dump_girder_to_s3 <<EOF
#!/bin/bash
mongodump --db girder
aws s3 cp --recursive dump s3://girder-data/dump
echo "dump completed on `date`"
EOF
chmod +x dump_girder_to_s3
# (crontab -l ; echo "0 1 * * * cd ~ && ./dump_girder_to_s3 > dump_to_s3_log") | crontab
