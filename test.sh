#!/usr/bin/env bash

docker-compose up

# SESSION_SECRET=secret
# DB_HOST=testdb
# DB_USER=test
# DB_PASS=password
# DB_NAME=test
# NET_NAME=test
# AC_NAME=test
#
# sudo docker stop $AC_NAME
# sudo docker stop $DB_HOST
# sudo docker rm $AC_NAME
# sudo docker rm $DB_HOST
#
# sudo docker network create $NET_NAME
# sudo docker run --name $DB_HOST -e POSTGRES_PASSWORD=$DB_PASS \
#  -e POSTGRES_USER=$DB_USER -e POSTGRES_DB=$DB_NAME \
#  --network $NET_NAME --restart unless-stopped \
#  -d postgres:12.1-alpine
# sudo docker run --name $AC_NAME --network $NET_NAME -p 8000:80 \
#  -e SESSION_SECRET=$SESSION_SECRET -e DB_HOST=$DB_HOST \
#  -e DB_USER=$DB_USER -e DB_PASS=$DB_PASS -e DB_NAME=$DB_NAME \
#  --restart unless-stopped -d guard13007/ellis:testing
