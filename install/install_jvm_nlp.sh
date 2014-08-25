#!/bin/bash
cd ~/grits-api/jvm-nlp

# Tomcat installation for jvm-nlp
sudo apt-get install -y default-jre default-jdk tomcat7

sudo tee /etc/default/tomcat7 <<EOF
TOMCAT7_USER=tomcat7
TOMCAT7_GROUP=tomcat7
JAVA_OPTS="-Djava.awt.headless=true -Xmx1536m -XX:+UseConcMarkSweepGC"
EOF

./sbt package

sudo rm -rf /var/lib/tomcat7/webapps/ROOT*
sudo cp target/scala-2.11/*.war /var/lib/tomcat7/webapps/ROOT.war

sudo service tomcat7 restart
