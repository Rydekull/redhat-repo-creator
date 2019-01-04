#!/bin/bash

RH_USERNAME=${RH_USERNAME:-default}
RH_PASSWORD=${RH_PASSWORD:-default}
RH_POOL_ID=${RH_POOL_ID:-default}

if [ "${RH_PASSWORD}" = "default" ]
then
  read -sp "Password: " RH_PASSWORD
fi

docker stop redhat-repo-creator

if [ "$(docker ps -f name=redhat-repo-creator | grep -c redhat-repo-creator)" -eq "1" ]
then
  docker exec -it redhat-repo-creator /app/scripts/create-repo.sh
else
  docker build -t redhat-repo-creator --build-arg RH_USERNAME=$RH_USERNAME --build-arg RH_PASSWORD=$RH_PASSWORD --build-arg RH_POOL_ID=$RH_POOL_ID .
  docker run -v $(pwd)/../:/app:z -it --rm --entrypoint /app/scripts/create-repo.sh --name redhat-repo-creator redhat-repo-creator 
  docker run -v $(pwd)/../:/app:z -d --rm -p 192.168.122.1:80:80 --name redhat-repo-creator redhat-repo-creator 
fi
docker exec -it redhat-repo-creator bash
