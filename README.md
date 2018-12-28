mv /usr/share/rhel/secrets /usr/share/rhel/secrets-old # if on Fedora/CentOS, so we can run subscription-manager in the container

export RH_USERNAME=username

cd scripts

./start_redhat-repo-creator.sh

Enter your password and wait for it to finish

Once inside the newly created docker container:

cd /app/scripts

./create-repo.sh
