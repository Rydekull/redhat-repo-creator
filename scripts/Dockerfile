FROM registry.access.redhat.com/rhel7:latest

ARG RH_USERNAME
ARG RH_PASSWORD
ARG RH_POOL_ID
ENV RH_USERNAME=${RH_USERNAME} RH_PASSWORD=${RH_PASSWORD} RH_POOL_ID=${RH_POOL_ID} 

RUN echo ${RH_USERNAME} ${RH_PASSWORD} ${RH_POOL_ID}

RUN subscription-manager register --username ${RH_USERNAME} --password ${RH_PASSWORD} --auto-attach 
#RUN subscription-manager attach --pool ${RH_POOL_ID}
RUN subscription-manager repos --disable '*' --enable rhel-7-server-rpms

RUN yum update -y ; yum clean all

RUN yum install https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm -y
RUN yum install p7zip xorriso syslinux createrepo httpd -y
RUN ln -s /app/htmlpub /var/www/html/pub

WORKDIR /app
CMD ["-DFOREGROUND"]
ENTRYPOINT ["/usr/sbin/httpd"]
