#!/bin/bash
docker run -it -d --env="MYSQL_ROOT_PASSWORD=mypassword" --env="MYSQL_DATABASE=fedora3" --env="MYSQL_USER=fedoraAdmin" --env="MYSQL_PASSWORD=fedoraAdmin" mysql
docker run -it -d -p 80:8080 --add-host=db:172.17.0.2 fedora3_karaf /root/runall.sh
