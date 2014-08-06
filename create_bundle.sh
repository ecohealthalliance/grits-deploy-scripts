#!/bin/bash
mkdir grits-bundle
cp -r grits-deploy-scripts grits-bundle
cp grits-deploy-scripts/README.md grits-bundle/README.md
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
git checkout tags/bundle0.0.1
git pull
cd ..
git clone git@github.com:ecohealthalliance/grits-api.git ; cd grits-api
git checkout tags/bundle0.0.0
git pull
aws s3 cp --recursive s3://classifier-data .
mv translations corpora
git clone git@github.com:ecohealthalliance/annie.git ; cd annie
git checkout master
git pull
git clone git@github.com:ecohealthalliance/jvm-nlp.git ; cd jvm-nlp
git checkout master
git pull
cd ../../..
tar -pczf grits-bundle.tar.gz grits-bundle --exclude-vcs
