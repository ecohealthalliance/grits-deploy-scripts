### GRITS installation

This project provides installation scripts for the GRITS suite, including the 
[diagnostic-dashboard](https://github.com/ecohealthalliance/diagnostic-dashboard) 
user interface, the [grits-api](https://github.com/ecohealthalliance/grits-api) 
backend, the [girder](https://github.com/ecohealthalliance/girder) database, and 
all dependencies.

### Usage

The install scripts presume you are running on a Linux-like environment and have 
`apt-get` in your path. This project is suitable for running on a fresh EC2 
instance that requires most components to be installed. If your environment 
differs from these expectations you may prefer to install the components individually (see below).

### Creating a config file for your deployment:

If you are deploying a prepackaged bundle, you may need to extract it to
edit the config file.

    tar -xvzf grits-bundle.tar.gz

Once you've made your changes you can rearchive it with this command:

    tar -pczf grits-bundle.tar.gz grits-bundle

It you have access the the EHA private repositories you can clone the deploy
scripts repository and use it to create a new bundle:

    git clone git@github.com:ecohealthalliance/grits-deploy-scripts.git

To edit the config file:

    # Copy the sample config file
    cp grits-deploy-scripts/config.sample grits-deploy-scripts/config
    # Then fill it out with the specifics of your deployment
    pico grits-deploy-scripts/config

### Bundling the code for deployment and distribution:

As prerequisites for budling you will need to set up git using an account
that has access to the EHA repositories and you will need to set up the AWS S3 CLI
with credentials that allow access to our classifier-data bucket.
You should also set the branches you want to use in the create_bundle script
prior to executing it.

    . grits-deploy-scripts/create_bundle.sh

### Setting up a server:

Unless you have in-depth knowledge of the grits source code,
we recommend only deploying it on dedicated machines.
Other processes on the system may conflict with it.

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

### Individual installs

If you wish to run GRITS by installing individual components manually, this can 
be easily done by reading the individual components documentation and following 
the install instructions therein:

* [diagnostic-dashboard](https://github.com/ecohealthalliance/diagnostic-dashboard)
* [grits-api](https://github.com/ecohealthalliance/grits-api)
* [girder](https://github.com/ecohealthalliance/girder)





