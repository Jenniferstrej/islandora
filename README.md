# islandora

Build java tomcat

docker build -t java_tomcat:0.1 .

Run java tomcat

docker run -it -d -p 8080:8080 java_tomcat:0.1 "./catalina-run.sh"

Build fedora karaf

docker build -t fedora_karaf .

Run Fedora Karaf

docker run  -it -d -p 8080:8080 fedora_karaf  "/root/runall.sh"

Buld Solr

docker build -t solr

Run Solr 

docker run -it -d -p 8081:8080 solr "./catalina-run.sh"

Build Fuseki

docker build -t fuseki .

Run Fuseki

docker run -it -d -p 8082:8080 fuseki "./catalina-run.sh"

