#!/bin/bash

BASE=$CI_PROJECT_DIR
DISTRO="centos5 centos6 centos7 precise trusty xenial bionic wheezy jessie stretch"
OUT=.gitlab-ci.yml

cat > $OUT <<EOF
image: docker:latest

services:
 - docker:dind

stages:
 - build
 - test
 - deploy

before_script:
 - docker info

EOF

for x in $DISTRO
do
    echo $x
        echo "
build-$x:
 stage: test
 script:
  - docker build -t buildpack-$x \$CI_PROJECT_DIR/$x
  - docker tag buildpack-$x udienz/buildpack:$x
  - docker login -u=\"\$DOCKERUSER\" -p=\"\$DOCKERPASS\"
  - docker push udienz/buildpack:$x" >> $OUT
done
echo "
stage: test
script:
  - docker build -t buildpack-latest \$CI_PROJECT_DIR/xenial
  - docker tag buildpack-latest udienz/buildpack:latest
  - docker login -u=\"\$DOCKERUSER\" -p=\"\$DOCKERPASS\"
  - docker push udienz/buildpack:latest

trigger:
  type: deploy
  script:
    - "curl -X POST -F token=$TOKEN -F ref=$REF_NAME https://git.mahyudd.in/api/v3/projects/155/trigger/builds"
  when: on_success" >> $OUT
