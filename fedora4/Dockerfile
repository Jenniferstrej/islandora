FROM java_tomcat:0.1

MAINTAINER Jen and Adam “jennifer.strejevitch@digirati.co.uk”

ARG FedoraConfig=
ARG ModeshapeConfig=file-simple

RUN echo 'JAVA_OPTS="$JAVA_OPTS -Dfcrepo.modeshape.configuration=classpath:/config/'$ModeshapeConfig'/repository.json -Dfcrepo.home=/mnt/ingest -Dfcrepo.audit.container=/audit"' > $CATALINA_HOME/bin/setenv.sh \
	&& chmod +x $CATALINA_HOME/bin/setenv.sh

# Make the ingest directory
RUN mkdir /mnt/ingest \
	&& chown -R tomcat7:tomcat7 /mnt/ingest


VOLUME /mnt/ingest


# Install Fedora4
ENV FEDORA_VERSION 4.7.0
ENV FEDORA_TAG 4.7.0

RUN mkdir -p /var/lib/tomcat7/fcrepo4-data \
	&& chown tomcat7:tomcat7 /var/lib/tomcat7/fcrepo4-data \
	&& chmod g-w /var/lib/tomcat7/fcrepo4-data \
	&& cd /tmp \
	&& curl -fSL https://github.com/fcrepo4-exts/fcrepo-webapp-plus/releases/download/fcrepo-webapp-plus-$FEDORA_TAG/fcrepo-webapp-plus-$FedoraConfig$FEDORA_VERSION.war -o fcrepo.war \
	&& cp fcrepo.war /usr/local/tomcat7/webapps/fcrepo.war \
	&& chown tomcat7:tomcat7 /usr/local/tomcat7/webapps/fcrepo.war 


COPY scripts/runall.sh /root/

EXPOSE 8080
EXPOSE 9080

