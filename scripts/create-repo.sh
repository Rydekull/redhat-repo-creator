#!/bin/bash
# Currently just downloads all repos enabled on the machine
set -e

cd "$(dirname "${BASH_SOURCE[0]}" )"

CA=/etc/rhsm/ca/redhat-uep.pem
KEY=$(ls /etc/pki/entitlement/*-key.pem | head -n 1)
CERT=$(echo $KEY | sed 's/-key//g')
REPOS=""

echo Syncing repos
mkdir -p ../htmlpub/repos
cd ../htmlpub/repos
reposync
for REPO in $(ls) ; do echo ; echo $REPO ; createrepo $REPO ; done
