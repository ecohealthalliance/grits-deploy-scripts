#!/bin/bash
#Script based on these [instructions](http://docs.mongodb.org/manual/tutorial/install-mongodb-on-linux/)
cd ~
curl -O http://downloads.mongodb.org/linux/mongodb-linux-x86_64-2.6.2.tgz
tar -zxvf mongodb-linux-x86_64-2.6.2.tgz
mkdir -p mongodb
cp -R -n mongodb-linux-x86_64-2.6.2/ mongodb
echo 'export PATH=~/mongodb/mongodb-linux-x86_64-2.6.2/bin/:$PATH' | tee -a ~/.bashrc
source ~/.bashrc
mkdir -p ~/data/db
mongod --fork --logpath ~/mongodb.log --dbpath ~/data/db

