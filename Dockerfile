# Pull base image
# ---------------
FROM centos:latest

# Maintainer
# ----------
MAINTAINER Tomáš Horák <tomashorak@post.cz>

RUN yum -y upgrade && \
	yum -y install libtommath && yum -y install libicu.x86_64 && \
	yum -y install unzip wget tar  && \
	yum clean all

ENV INSTALL_DIR=/opt/install \
	FB_DIR=/opt/firebird

COPY installFB.sh $INSTALL_DIR/ 

RUN $INSTALL_DIR/installFB.sh

EXPOSE 3050

ENTRYPOINT exec $FB_DIR/bin/firebird

