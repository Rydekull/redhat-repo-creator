#!/bin/bash
CA=/etc/rhsm/ca/redhat-uep.pem
KEY=$(ls /etc/pki/entitlement/*-key.pem | head -n 1)
CERT=$(echo $KEY | sed 's/-key//g')
RH_ISO_URL=https://cdn.redhat.com/content/dist/rhel/server/7/7Server/x86_64/iso
REPOS="rhel-7-server-extras-rpms rhel-7-fast-datapath-rpms rhel-7-server-ose-3.6-rpms"

ISO=$(curl -s --cacert ${CA} --cert ${CERT} --key ${KEY} ${RH_ISO_URL} | awk '$0 ~ /rhel-server/ && $0 ~ /dvd\.iso/ {gsub(/ *<[^>]*> */," ");print }' | sort -t- -k 2,2n -k 3 | awk 'END{ print $1 }')

if [ ! -f "../${ISO}" ]
then
  curl --cacert ${CA} --cert ${CERT} --key ${KEY} ${RH_ISO_URL}/${ISO} -o ../${ISO}
fi

exit
