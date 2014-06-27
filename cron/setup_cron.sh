#!/bin/bash
cp -r ~/grits-deploy-scripts/cron ~/cron
# At this point everything is ready to start importing the healthmap data.
# To import the last day, use the script in this repo `healthMapGirder.py`:

# python healthMapGirder.py --day

# for a full two year import:

# python healthMapGirder.py --full

# This runs a two day import every day just to make sure it gets the full days data.
# crontab -l might throw 'no crontab for user' but it's nothing to worry about.
(
crontab -l ;
echo "0 1 * * * cd ~ && girder/girder_env/bin/python cron/healthMapGirder.py --twoday"
) | crontab

(
crontab -l ;
echo "0 1 * * * cd ~ && cron/dump_girder_to_s3.sh > cron/dump_to_s3_log"
) | crontab
