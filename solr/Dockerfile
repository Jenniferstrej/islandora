FROM java_tomcat:0.1

MAINTAINER Jen and Adam “jennifer.strejevitch@digirati.co.uk”

# Install Solr
ENV SOLR_VERSION 4.10.3
ENV SOLR_HOME /usr/local/tomcat7/solr

RUN cd /tmp \
	&& curl -fSL http://archive.apache.org/dist/lucene/solr/$SOLR_VERSION/solr-$SOLR_VERSION.tgz -o solr-$SOLR_VERSION.tgz \
	&& curl -fSL http://repo1.maven.org/maven2/commons-logging/commons-logging/1.1.2/commons-logging-1.1.2.jar -o commons-logging-1.1.2.jar \
	&& mkdir -p "$SOLR_HOME" \
	&& tar -xzf solr-"$SOLR_VERSION".tgz \
	&& cp -v /tmp/solr-"$SOLR_VERSION"/dist/solr-"$SOLR_VERSION".war /usr/local/tomcat7/webapps/solr.war \
	&& chown tomcat7:tomcat7 /usr/local/tomcat7/webapps/solr.war \
	&& cp "commons-logging-1.1.2.jar" /usr/local/tomcat7/lib \
	&& cp /tmp/solr-"$SOLR_VERSION"/example/lib/ext/slf4j* /usr/local/tomcat7/lib \
	&& cp /tmp/solr-"$SOLR_VERSION"/example/lib/ext/log4j* /usr/local/tomcat7/lib \
	&& chown -hR tomcat7:tomcat7 /usr/local/tomcat7/lib \
	&& cp -Rv /tmp/solr-"$SOLR_VERSION"/example/solr/* $SOLR_HOME \
	&& chown -hR tomcat7:tomcat7 $SOLR_HOME \
	&& mkdir -p /var/lib/tomcat7 \
	&& touch /var/lib/tomcat7/velocity.log \
	&& chown tomcat7:tomcat7 /var/lib/tomcat7/velocity.log

COPY config/schema.xml $SOLR_HOME/collection1/conf/

RUN chown -hR tomcat7:tomcat7 $SOLR_HOME
