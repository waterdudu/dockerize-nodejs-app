# This dockerfile uses the ubuntu image
# VERSION 2 - EDITION 1
FROM centos:centos6

MAINTAINER dudu fianceeyi@@email.com

RUN yum install -y epel-release
RUN yum install -y nodejs npm

COPY package.json /src/package.json
RUN cd /src; npm install

copy ./src /src

EXPOSE 8080

CMD ["node", "/src/index.js"]
