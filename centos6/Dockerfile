# base image
FROM centos:centos6

MAINTAINER Mahyuddin Susanto <mahyuddin@wowrack.com>

# Install Packages
RUN yum update -y \
    && yum install -y --nogpg epel-release \
    && yum install --nogpg wget subversion bzrtools mercurial cvs rubygems ruby-devel \
    && yum groupinstall "Development tools" -y \
    && yum update -y \
    && yum clean all
