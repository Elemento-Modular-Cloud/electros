#!/bin/bash


function prepare {
# check if docker is running
echo "Preparando le cartelle e creando ./init/initdb.sql"

#creo cartelle per db, nginx e guacamole
mkdir ./init >/dev/null 2>&1
mkdir -p ./nginx/ssl >/dev/null 2>&1

#permessi (sudo non necessario)
sudo chmod -R u+rwx ./connections/ #non sono sicuro
sudo chmod -R +x ./init
sudo chmod -R u+rwx ./extensions
sudo chmod -R u+rwx ./guachome

#docker run --rm guacamole/guacamole /opt/guacamole/bin/initdb.sh --postgres > ./init/initdb.sql
echo "fine"
#self-signed certificate in ./nginx/ssl/ with ./nginx/ssl/self-ssl.key and ./nginx/ssl/self.cert.
#echo "Creating SSL certificates"
#openssl req -nodes -newkey rsa:2048 -new -x509 -keyout nginx/ssl/self-ssl.key -out nginx/ssl/self.cert -subj '/C=DE/ST=BY/L=Hintertupfing/O=Dorfwirt/OU=Theke/CN=www.createyourown.domain/emailAddress=docker@createyourown.domain'
echo "Puoi utilizzarre i tuoi certificati mettendo la private key in nginx/ssl/self-ssl.key e la certificazione in nginx/ssl/self.cert"
echo "fine"

}

prepare

#prepare function creates ./init/initdb.sql by downloading the docker image guacamole/guacamole and start it like this:
#docker run --rm guacamole/guacamole /opt/guacamole/bin/initdb.sh --postgres > ./init/initdb.sql
#It creates the necessary database initialization file for postgres.
#prepare function 
#also creates the self-signed certificate ./nginx/ssl/self.cert and the private key ./nginx/ssl/self-ssl.key which are used by nginx for https.

#avvia tutti i containers 
if ! (docker ps >/dev/null 2>&1)
then
	echo "docker daemon not running! (> sudo systemctl start docker.service)"
else
	docker-compose up -d 
fi


echo " "
echo "Trovi il la GUI di Apache Guacamole all'indirizzo: https://<ip del server>:8443/"
echo "https://localhost:8443/"
echo "utente di default è 'guacadmin' con password 'guacadmin'"
echo "Trovi il sito internet all'indirizzo: http://<ip del server>:80/"
echo "http://localhost:80/"
echo "per resettare tutto lo stack Guacamole esegui lo script ./reset.sh."




