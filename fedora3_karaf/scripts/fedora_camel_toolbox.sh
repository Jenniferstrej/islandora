######################
# Fedora Camel Toolbox
######################

/opt/karaf/bin/client -u karaf -h localhost -a 8101 -f "/root/fedora_camel_toolbox.script"

# ActiveMQ
if [ ! -f "/opt/karaf/etc/org.fcrepo.camel.service.activemq.cfg" ]; then
   /opt/karaf/bin/client -u karaf -h localhost -a 8101 "feature:install fcrepo-service-activemq"
fi

# LDPath
if [ ! -f "/opt/karaf/etc/org.fcrepo.camel.ldpath.cfg" ]; then
  /opt/karaf/bin/client -u karaf -h localhost -a 8101 "feature:install fcrepo-ldpath"
fi

sed -i 's|fcrepo.authUsername=$|fcrepo.authUsername=fedoraAdmin|' /opt/karaf/etc/org.fcrepo.camel.ldpath.cfg
sed -i 's|fcrepo.authPassword=$|fcrepo.authPassword=secret3|' /opt/karaf/etc/org.fcrepo.camel.ldpath.cfg


# Solr indexing
if [ ! -f "/opt/karaf/etc/org.fcrepo.camel.indexing.solr.cfg" ]; then
   /opt/karaf/bin/client -u karaf -h localhost -a 8101 "feature:install fcrepo-indexing-solr"
fi
# Solr base url
sed -i 's|solr.baseUrl=http://localhost:8983/solr/collection1|solr.baseUrl=http://search:8080/solr/collection1|' /opt/karaf/etc/org.fcrepo.camel.indexing.solr.cfg
# Solr JMS broker url
sed -i 's|jms.brokerUrl=tcp://localhost:61616|jms.brokerUrl=tcp://messaging:61616|' /opt/karaf/etc/org.fcrepo.camel.indexing.solr.cfg

# Triplestore indexing
if [ ! -f "/opt/karaf/etc/org.fcrepo.camel.indexing.triplestore.cfg" ]; then
   /opt/karaf/bin/client -u karaf -h localhost -a 8101 "feature:install fcrepo-indexing-triplestore"
fi
# Triplestore base url
sed -i 's|triplestore.baseUrl=http://localhost:8080/fuseki/test/update|triplestore.baseUrl=http://triplestore:8080/fuseki/test/update|' /opt/karaf/etc/org.fcrepo.camel.indexing.triplestore.cfg

# Audit service
if [ ! -f "/opt/karaf/etc/org.fcrepo.camel.audit.cfg" ]; then
   /opt/karaf/bin/client -u karaf -h localhost -a 8101 "feature:install fcrepo-audit-triplestore"
fi
# Audit service triplestore base url
sed -i 's|triplestore.baseUrl=http://localhost:8080/fuseki/test/update|triplestore.baseUrl=http://triplestore:8080/fuseki/test/update|' /opt/karaf/etc/org.fcrepo.camel.audit.cfg

# Fixity service
sleep 10
if [ ! -f "/opt/karaf/etc/org.fcrepo.camel.fixity.cfg" ]; then
   /opt/karaf/bin/client -u karaf -h localhost -a 8101 "feature:install fcrepo-fixity"
   sleep 10
fi

# Serialization service
if [ ! -f "/opt/karaf/etc/org.fcrepo.camel.serialization.cfg" ]; then
   /opt/karaf/bin/client -u karaf -h localhost -a 8101 "feature:install fcrepo-serialization"
fi

# Reindexing service
if [ ! -f "/opt/karaf/etc/org.fcrepo.camel.reindexing.cfg" ]; then
   /opt/karaf/bin/client -u karaf -h localhost -a 8101 "feature:install fcrepo-reindexing"
fi
sed -i 's|rest.host=localhost$|rest.host=0.0.0.0|' /opt/karaf/etc/org.fcrepo.camel.reindexing.cfg

sed -i 's|fcrepo.authUsername=$|fcrepo.authUsername=fedoraAdmin|' /opt/karaf/etc/org.fcrepo.camel.service.cfg
sed -i 's|fcrepo.authPassword=$|fcrepo.authPassword=secret|' /opt/karaf/etc/org.fcrepo.camel.service.cfg

