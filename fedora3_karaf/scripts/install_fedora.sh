#!/bin/bash

echo "Downloading Fedora"
wget -q -O "/tmp/fcrepo-installer-3.8.1.jar" "https://github.com/fcrepo3/fcrepo/releases/download/v3.8.1/fcrepo-installer-3.8.1.jar"

echo "Installing Fedora"
java -jar /tmp/fcrepo-installer-3.8.1.jar /root/fcrepo3/install.properties

# Deploy fcrepo
chown tomcat7:tomcat7 "$CATALINA_HOME/webapps/fedora.war"

