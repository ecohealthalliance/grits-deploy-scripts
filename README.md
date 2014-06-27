To set-up and deploy grits run the following commands:

    sudo apt-get install -y git
    git clone https://github.com/ecohealthalliance/grits-deploy-scripts.git
    cd grits-deploy-scripts
    source config
    ./install.sh

To deploy to a remote server:

    git clone https://github.com/ecohealthalliance/grits-deploy-scripts.git
    scp -i ~/.keys/grits-dev.pem -r grits-deploy-scripts grits-dev.ecohealth.io:
    ssh -i ~/.keys/grits-dev.pem grits-dev.ecohealth.io 'cd grits-deploy-scripts && source config && ./install.sh'
    