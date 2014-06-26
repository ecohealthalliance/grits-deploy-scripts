#!/bin/bash
. ~/grits-deploy-scripts/install/install_mongo.sh
. ~/grits-deploy-scripts/install/install_node.sh
. ~/grits-deploy-scripts/install/girder_s3_restore.sh
. ~/grits-deploy-scripts/install/girder_setup.sh
. ~/grits-deploy-scripts/install/install_grits_api.sh
. ~/grits-deploy-scripts/install/supervisord_setup.sh
. ~/grits-deploy-scripts/install/install_dashboard.sh
. ~/grits-deploy-scripts/install/apache_setup.sh
