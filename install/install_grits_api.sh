#!/bin/bash

cd ~
git clone https://$GIT_USER:$GIT_PASSWORD@github.com/ecohealthalliance/grits-api.git

sudo apt-get install -y git make python-pip python-dev
sudo apt-get install -y gfortran libopenblas-dev liblapack-dev
sudo apt-get install -y lib32z1-dev zip unzip libxml2-dev libxslt1-dev


cd ~/grits-api
# create a config file
cp config.sample.py config.py
# set up a virtual env
sudo pip install virtualenv virtualenvwrapper
echo 'export WORKON_HOME=~/Envs' | tee -a ~/.bashrc
echo 'source /usr/local/bin/virtualenvwrapper.sh' | tee -a ~/.bashrc
source ~/.bashrc
virtualenv grits_api_env
. grits_api_env/bin/activate
pip install -r requirements.txt
# Import geonames for the location extractor
./import_geonames.sh
# This script does the rest. Rerun it to update when the code changes.
./deploy.sh
