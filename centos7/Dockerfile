# base image
FROM udienz/buildpack:centos7

MAINTAINER Mahyuddin Susanto <mahyuddin@wowrack.com>

# Install Packages
RUN yum update -y \
    && yum install -y --nogpg epel-release \
    && yum install -y --nogpg wget subversion bzrtools mercurial cvs \
    && yum groupinstall -y "Development Tools" \
    && yum update -y \
    && yum clean all
