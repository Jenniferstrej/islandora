#!/bin/bash

cd $CATALINA_HOME
catalina.sh run &

echo waiting for tomcat to start up
sleep 45

cd $CATALINA_HOME
echo stopping tomcat...
catalina.sh stop

echo adding logging
cp /root/fcrepo3/logging.properties "$CATALINA_HOME/webapps/fedora/WEB-INF/classes/."

cd $CATALINA_HOME
catalina.sh run &

echo waiting for tomcat to start up
sleep 45

echo starting karaf
/opt/karaf/bin/start

echo sleeping for 5 seconds
sleep 5

/opt/karaf/bin/client -f /root/karaf_service.script
/opt/karaf/bin/stop
#ln -s /opt/karaf/bin/karaf-service /etc/init.d/
#update-rc.d karaf-service defaults 
sed -i "s|#org.ops4j.pax.url.mvn.localRepository=|org.ops4j.pax.url.mvn.localRepository=~/.m2/repository|" /opt/karaf/etc/org.ops4j.pax.url.mvn.cfg
/opt/karaf/bin/start

echo sleeping for 60 seconds
sleep 60

/root/fedora_camel_toolbox.sh
/opt/karaf/bin/stop

echo sleeping for 30 seconds
sleep 30

/opt/karaf/bin/start

echo sleeping for 60 seconds
sleep 60

cd $CATALINA_HOME
echo stopping tomcat...
catalina.sh stop

echo starting tomcat...
catalina.sh run
