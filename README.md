Before deploying:

    # Create a config file
    mv config.sample config
    # Fill it out with the specifics of your deployment
    pico config

To set-up and deploy grits run the following commands:

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
    
