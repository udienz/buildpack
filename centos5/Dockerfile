FROM centos:centos5

MAINTAINER Mahyuddin Susanto <mahyuddin@wowrack.com>

# Install Packages
RUN yum update -y \
    && rpm -ivh http://dl.fedoraproject.org/pub/epel/5/x86_64/epel-release-5-4.noarch.rpm \
    && yum install --nogpg -y wget subversion bzrtools mercurial cvs git \
    && yum groupinstall -y "Development Tools" \
    && yum clean all
