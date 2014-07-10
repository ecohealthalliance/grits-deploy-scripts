### Creating a config file for your deployment:

    git clone git@github.com:ecohealthalliance/grits-deploy-scripts.git
    # copy the sample config file
    cp grits-deploy-scripts/config.sample config
    # Fill it out with the specifics of your deployment
    pico config
    cp config grits-deploy-scripts/
    
### Bundling the code for deployment and distribution:

As prerequisites for budling you will need to set up git using an account
that has access to our repositories
and you will need to set up the aws s3 CLI with access to our classifier-data bucket.

    . grits-deploy-scripts/create_bundle.sh

### Setting up a server:

Unless you have in depth knowledge of the grits source code,
we recommend only deploying it on dedicated machines.
Other processes on the system may conflict with it and vice-versa.

In all our deployments we have used Ubuntu 14.04 LTS 64bit 4+vCPU AWS instances.
These instance are stock AWS instances. When launching the instance
open ports 80 and 443 on its security group and configure the storage device to
provide at least 40GB of disk space.

To deploy the bundle if it is already present on a machine:

    tar -xvzf grits-bundle.tar.gz --strip-components=1 -C ~ && cd grits-deploy-scripts && source config && ./install.sh

To deploy the bundle to a remote server over ssh:

    export INSTANCE_URL=grits-dev.ecohealth.io
    scp -i ~/.keys/grits-dev.pem grits-bundle.tar.gz $INSTANCE_URL:
    ssh -i ~/.keys/grits-dev.pem $INSTANCE_URL 'tar -xvzf grits-bundle.tar.gz --strip-components=1 -C ~ && cd grits-deploy-scripts && source config && ./install.sh'

Places to look for log files:

    /var/log/supervisor/
    forever list
