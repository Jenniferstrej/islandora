FROM java_tomcat:0.1

MAINTAINER Jen and Adam “jennifer.strejevitch@digirati.co.uk”

# Install Fuseki
ENV FUSEKI_VERSION 2.3.1
ENV FUSEKI_BASE /mnt/fuseki
ENV FUSEKI_DEPLOY /usr/local/tomcat7/webapps

RUN cd && mkdir -p "$FUSEKI_BASE" \ 
	&& mkdir -p "$FUSEKI_BASE"/configuration \
	&& chown -hR tomcat7:tomcat7 $FUSEKI_BASE \
	&& cd /tmp \
	&& curl -fSL http://archive.apache.org/dist/jena/binaries/apache-jena-fuseki-$FUSEKI_VERSION.tar.gz -o apache-jena-fuseki-$FUSEKI_VERSION.tar.gz \
	&& tar -xzvf apache-jena-fuseki-$FUSEKI_VERSION.tar.gz \
	&& mv apache-jena-fuseki-"$FUSEKI_VERSION" jena-fuseki1-"$FUSEKI_VERSION" \
	&& cd jena-fuseki1-"$FUSEKI_VERSION" \
	&& mv -v fuseki.war $FUSEKI_DEPLOY \
	&& chown -hR tomcat7:tomcat7 $FUSEKI_DEPLOY/fuseki.war

COPY config/shiro.ini /root/
COPY config/test.ttl /root/

RUN cp /root/shiro.ini  "$FUSEKI_BASE"/. \
	&& cp /root/test.ttl  "$FUSEKI_BASE"/configuration/.
