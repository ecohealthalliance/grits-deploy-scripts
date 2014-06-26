#!/bin/bash

cd ~/grits-deploy-scripts
# create directory for logging
mkdir supervisord
supervisord -c supervisord.conf
