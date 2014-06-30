#!/bin/bash
# Install shared packages that many of the scripts below depend on:
sudo apt-get install -y git make python-pip python-dev
sudo apt-get install -y gfortran libopenblas-dev liblapack-dev
sudo apt-get install -y lib32z1-dev zip unzip libxml2-dev libxslt1-dev
# Install these python packages as sudo so they are available in all environments.
sudo pip install awscli virtualenv

# Configure supervisor daemons
sudo apt-get install -y supervisor
sudo cp -r supervisord/* /etc/supervisor/conf.d
sudo supervisorctl update

. ~/grits-deploy-scripts/install/install_mongo.sh
. ~/grits-deploy-scripts/install/install_node.sh
. ~/grits-deploy-scripts/install/girder_s3_restore.sh
. ~/grits-deploy-scripts/install/girder_setup.sh
. ~/grits-deploy-scripts/install/install_grits_api.sh
. ~/grits-deploy-scripts/install/install_dashboard.sh
. ~/grits-deploy-scripts/install/apache_setup.sh
. ~/grits-deploy-scripts/cron/setup_cron.sh
