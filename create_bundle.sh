#!/bin/bash
mkdir grits-bundle
cp -r grits-deploy-scripts grits-bundle
cd grits-bundle
git clone git@github.com:girder/girder.git
cd girder ; git pull ; cd .. # Update the repo if it already exists
cd girder/plugins
git clone git@github.com:ecohealthalliance/gritsSearch.git
cd gritsSearch ; git pull ; cd ..
cd ..
git clone -b master git@github.com:ecohealthalliance/diagnostic-dashboard.git
cd diagnostic-dashboard ; git pull ; cd ..
git clone -b master git@github.com:ecohealthalliance/grits-api.git
cd grits-api ; git pull ; cd ..
cd ..
tar -pczf grits-bundle.tar.gz grits-bundle
