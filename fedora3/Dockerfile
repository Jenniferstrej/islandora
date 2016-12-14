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


# Install Fedora3
#run installation 

COPY scripts/runall.sh /root/

EXPOSE 8080
EXPOSE 9080

