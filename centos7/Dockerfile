# base image
FROM centos:centos7

MAINTAINER Mahyuddin Susanto <mahyuddin@wowrack.com>

# Install Packages
RUN yum update -y \
    && yum install -y --nogpg epel-release \
    && yum install -y --nogpg wget subversion bzrtools mercurial cvs git\
    && yum groupinstall -y "Development Tools" \
    && yum update -y \
    && yum clean all
