#!/bin/bash

cd ~
git clone -b $DASHBOARD_BRANCH https://$GIT_USER:$GIT_PASSWORD@github.com/ecohealthalliance/diagnostic-dashboard.git
cd ~/diagnostic-dashboard
cd ..

diagnostic-dashboard/install.sh
