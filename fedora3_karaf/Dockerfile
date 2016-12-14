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

# Install Apache Karaf
ENV KARAF_VERSION 4.0.5

COPY config/karaf_service.script /root/

RUN cd /tmp \
	&& wget -q -O "apache-karaf-$KARAF_VERSION.tar.gz" "http://archive.apache.org/dist/karaf/"$KARAF_VERSION"/apache-karaf-"$KARAF_VERSION".tar.gz" \
	&& tar -zxvf apache-karaf-$KARAF_VERSION.tar.gz \
	&& mv /tmp/apache-karaf-$KARAF_VERSION /opt \
	&& ln -s "/opt/apache-karaf-$KARAF_VERSION" /opt/karaf

# Fedora Camel Toolbox
COPY config/fedora_camel_toolbox.script /root/
COPY scripts/fedora_camel_toolbox.sh /root/

# Install Fedora
ENV FEDORA_HOME /usr/local/fedora

COPY scripts/install_fedora.sh /root/
COPY config/fcrepo3/install.properties /root/fcrepo3/
RUN /root/install_fedora.sh

#COPY config/fcrepo3/logging.properties /root/fcrepo3/
#RUN cp /root/fcrepo3/logging.properties "$CATALINA_HOME/webapps/fedora/WEB-INF/classes/."

COPY scripts/runall.sh /root/

EXPOSE 8080
EXPOSE 9080

