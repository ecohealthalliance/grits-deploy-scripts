#!/bin/bash
# Install shared packages that many of the scripts below depend on:
sudo apt-get install -y git make python-pip python-dev
sudo apt-get install -y gfortran libopenblas-dev liblapack-dev
sudo apt-get install -y lib32z1-dev zip unzip libxml2-dev libxslt1-dev
# Install these python packages as sudo so they are available in all environments.
sudo pip install awscli virtualenv

# Configure supervisor daemons
sudo apt-get install -y supervisor
cd ~/grits-deploy-scripts/supervisord
if [ -n "$FLOWER_PASSWORD" ]; then
    cat flowerd.conf | envsubst | sudo tee /etc/supervisor/conf.d/flowerd.conf
fi
cat celeryd.conf | envsubst | sudo tee /etc/supervisor/conf.d/celeryd.conf
cat girderd.conf | envsubst | sudo tee /etc/supervisor/conf.d/girderd.conf
cat gritsapid.conf | envsubst | sudo tee /etc/supervisor/conf.d/gritsapid.conf
cd ~
sudo supervisorctl update

. ~/grits-deploy-scripts/install/install_postfix.sh
. ~/grits-deploy-scripts/install/install_mongo.sh
. ~/grits-deploy-scripts/install/install_node.sh
. ~/grits-deploy-scripts/install/girder_s3_restore.sh
. ~/grits-deploy-scripts/install/girder_setup.sh
. ~/grits-deploy-scripts/install/install_grits_api.sh
. ~/grits-deploy-scripts/install/install_jvm_nlp.sh
sudo tee ~/diagnostic-dashboard/config <<EOF
#!/bin/bash
export PORT=$METEOR_PORT
export MONGO_URL=$METEOR_MONGO
export ROOT_URL=$APACHE_URL
export MAIL_URL=smtp://localhost
EOF
. ~/diagnostic-dashboard/install.sh
. ~/grits-deploy-scripts/install/apache_setup.sh
if [ "$RUN_CRON_JOBS" = "true" ]; then
    . ~/grits-deploy-scripts/cron/setup_cron.sh
fi
if [ "$DIAGNOSE_ON_LAUNCH" = "true" ]; then
    cd ~/grits-api
    grits_api_env/bin/python diagnose_girder_HM_articles.py
    cd ..
fi
