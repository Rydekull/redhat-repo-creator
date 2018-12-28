#!/bin/bash

RH_USERNAME=${RH_USERNAME:-default}
RH_PASSWORD=${RH_PASSWORD:-default}
RH_POOL_ID=${RH_POOL_ID:-default}

if [ "${RH_PASSWORD}" = "default" ]
then
  read -sp "Password: " RH_PASSWORD
fi

docker build -t redhat-repo-creator --build-arg RH_USERNAME=$RH_USERNAME --build-arg RH_PASSWORD=$RH_PASSWORD --build-arg RH_POOL_ID=$RH_POOL_ID .

docker run -v $(pwd)/../:/app:z -it --rm redhat-repo-creator bash
