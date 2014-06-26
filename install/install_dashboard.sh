#!/bin/bash

git clone https://$GIT_USER:$GIT_PASSWORD@github.com/ecohealthalliance/diagnostic-dashboard.git
cd diagnostic-dashboard
git checkout setup-instructions
cd ..

diagnostic-dashboard/install.sh
