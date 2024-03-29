#!/bin/bash

# configuration variables to set:

# APACHE_URL
# the root URL of the apache server, e.g.
# https://grits.ecohealth.io

# GIRDER_MOUNT_PATH
# the url path where girder is mounted
: ${GIRDER_MOUNT_PATH=/gritsdb}

# GIRDER_DEPLOYMENT_MODE
# 'production' or 'development', default to production:
: ${GIRDER_DEPLOYMENT_MODE=production}

# GIRDER_SOCKET_HOST
# host that girder will listen on
# default to local only
: ${GIRDER_SOCKET_HOST=127.0.0.1}

# GIRDER_SOCKET_PORT
# port that girder will listen on
# default to 9999
: ${GIRDER_SOCKET_PORT=9999}

# GIRDER_ADMIN_PASSWORD
# the password to set for the girder admin
# the user name for this account will be 'grits'

# GIRDER_ADMIN_EMAIL
# the email address for the girder admin account

# HEALTHMAP_APIKEY
# the api key for healthmap access

# go to the deployment directory
cd ~

sudo apt-get install -y libffi-dev

# create a new virtualenv for girder deps
# go to the main girder directory
cd ~/girder

virtualenv girder_env
. girder_env/bin/activate

# install python dependencies
pip install --requirement requirements.txt

# install other python deps
pip install requests python-dateutil

# install grunt
npm install grunt-cli

# set a variable to /path/to/grunt
export grunt="${PWD}/node_modules/.bin/grunt"

# install node dependencies
npm install

# configure the server:
cat > girder/conf/girder.local.cfg <<EOF
[global]
server.socket_host: "${GIRDER_SOCKET_HOST}"
server.socket_port: ${GIRDER_SOCKET_PORT}
tools.proxy.on: True
tools.proxy.base: "${APACHE_URL}${GIRDER_MOUNT_PATH}"
tools.proxy.local: ""

[server]
mode: "${GIRDER_DEPLOYMENT_MODE}"
api_root: "${GIRDER_MOUNT_PATH}/api/v1"
static_root: "${GIRDER_MOUNT_PATH}/static"
EOF

# build the source
"${grunt}" init && "${grunt}"

sudo supervisorctl start girder
directory=/home/ubuntu/grits_api
# either start up girder in a browser or run the following
# to create the grits user and enable the grits plugin
python <<EOF
import requests

url = 'http://${GIRDER_SOCKET_HOST}:${GIRDER_SOCKET_PORT}/api/v1'

passwd = '${GIRDER_ADMIN_PASSWORD}'

# do initialization of girder for healthmap import
# create main grits user
# When a database dump is imported this might not create the user,
# but the admin account from the dump will be there.
resp = requests.post(
    url + '/user',
    params={
        'login': 'grits',
        'password': passwd,
        'firstName': 'grits',
        'lastName': 'grits',
        'email': '${GIRDER_ADMIN_EMAIL}'
    },
    verify=False
)

# login as grits user (or as an admin)
resp = requests.get(
    url + '/user/authentication',
    auth=('grits', passwd),
    verify=False
)

if resp.status_code != requests.codes.ok:
    print "Cound not authenticate with girder."
else:
    token = resp.json()['authToken']['token']

    # enable grits plugin
    resp = requests.put(
        url + '/system/plugins',
        params={
            'plugins': '["grits"]',
            'token': token
        }
    )
EOF

# now we have to restart girder to enable the plugin
sudo supervisorctl restart girder

# now hit the grits api to initialize the database
curl "${GIRDER_SOCKET_HOST}:${GIRDER_SOCKET_PORT}/api/v1/resource/grits" &> /dev/null
