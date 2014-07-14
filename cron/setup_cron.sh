#!/bin/bash
cp -r ~/grits-deploy-scripts/cron ~/cron
# At this point everything is ready to start importing the healthmap data.
# To import the last day, use the script in this repo `healthMapGirder.py`:

# python healthMapGirder.py --day

# for a full two year import:

# python healthMapGirder.py --full

# This runs a two day import every day just to make sure it gets the full days data.
# crontab -l might throw 'no crontab for user' but it's nothing to worry about.
# We can't install girder to girder_env so we set the python path instead: 
# https://github.com/ecohealthalliance/grits-deploy-scripts/issues/11#issuecomment-48888666
(
crontab -l ;
echo "0 1 * * * cd ~ && source ~/grits-deploy-scripts/config && PYTHONPATH=~/girder girder/girder_env/bin/python cron/healthMapGirder.py --twoday > cron/hm_import_log 2> cron/hm_import_err"
) | crontab

(
crontab -l ;
echo "0 3 * * * cd ~/grits-api && source ~/grits-deploy-scripts/config && grits_api_env/bin/python diagnose_girder_HM_articles.py  > ~/cron/diagnose_girder_HM_articles_log 2> ~/cron/diagnose_girder_HM_articles_err"
) | crontab

(
crontab -l ;
echo "0 5 * * * cd ~ && source ~/grits-deploy-scripts/config && cron/dump_girder_to_s3.sh > cron/dump_girder_to_s3_log 2> cron/dump_girder_to_s3_err"
) | crontab

(
crontab -l ;
echo "0 6 * * * cd ~ && source ~/grits-deploy-scripts/config && cron/dump_meteor_to_s3.sh > cron/dump_meteor_to_s3_log 2> cron/dump_meteor_to_s3_err"
) | crontab
