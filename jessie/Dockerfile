FROM debian:wheezy
MAINTAINER Mahyuddin Susanto <udienz@gmail.com>

RUN apt-get update \
    && apt-get install -y --no-install-recommends  git subversion bzr mercurial cvs sudo ruby ruby-dev build-essential \
    && apt-get clean -y \
    && rm -rf /var/lib/apt/lists/*
