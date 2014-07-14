#!/bin/bash
mkdir grits-bundle
cp -r grits-deploy-scripts grits-bundle
cd grits-bundle
git clone git@github.com:girder/girder.git ; cd girder
# Update the repo if it already exists
git pull
cd ..
cd girder/plugins
git clone git@github.com:ecohealthalliance/gritsSearch.git ; cd gritsSearch
git pull
cd ..
cd ../..
git clone git@github.com:ecohealthalliance/diagnostic-dashboard.git ; cd diagnostic-dashboard
git checkout master
git pull
cd ..
git clone git@github.com:ecohealthalliance/grits-api.git ; cd grits-api
git checkout cumulative-count-tagging
git pull
aws s3 cp --recursive s3://classifier-data .
mv translations corpora
cd ..
cd ..
tar -pczf grits-bundle.tar.gz grits-bundle