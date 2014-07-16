# GRITS installation

This project provides installation scripts for the GRITS suite, including the [diagnostic-dashboard](https://github.com/ecohealthalliance/diagnostic-dashboard) user interface, the [grits-api](https://github.com/ecohealthalliance/grits-api) backend, the [girder](https://github.com/ecohealthalliance/girder) database, and all dependencies.

# Usage

The install scripts presume you are running on a Linux-like environment and have `apt-get` in your path. This project is suitable for running on a fresh EC2 instance that requires most components to be installed. If your environment differs from these expectations you may prefer to install the components individually (see below).

To set-up and deploy grits on run the following commands:

    sudo apt-get install -y git
    git clone https://github.com/ecohealthalliance/grits-deploy-scripts.git
    cd grits-deploy-scripts
    source config
    ./install.sh

To deploy to a remote server:

    export INSTANCE_URL=grits-dev.ecohealth.io
    git clone https://github.com/ecohealthalliance/grits-deploy-scripts.git
    scp -i ~/.keys/grits-dev.pem -r grits-deploy-scripts $INSTANCE_URL:
    ssh -i ~/.keys/grits-dev.pem $INSTANCE_URL 'cd grits-deploy-scripts && source config && ./install.sh'

Places to look for log files:

    /var/log/supervisor/

# Individual installs

If you wish to run GRITS by installing individual components manually, this can be easily done by reading the individual components documentation and following the install instructions therein:

* [diagnostic-dashboard](https://github.com/ecohealthalliance/diagnostic-dashboard)
* [grits-api](https://github.com/ecohealthalliance/grits-api)
* [girder](https://github.com/ecohealthalliance/girder)