#!/bin/bash

BASE=$CI_PROJECT_DIR
DISTRO="centos6 centos7 precise trusty xenial bionic focal wheezy jessie stretch buster"
OUT=../.gitlab-ci.yml

cat > $OUT <<EOF
image: docker:latest

services:
 - docker:dind

stages:
 - build
 - deploy

before_script:
 - docker info

EOF

for x in $DISTRO
do
    echo $x
        echo "
build-$x:
 stage: build
 except:
  refs:
   - master
 script:
  - docker build -t buildpack-$x \$CI_PROJECT_DIR/$x
  - docker tag buildpack-$x udienz/buildpack:$x
  - docker login -u=\"\$DOCKERUSER\" -p=\"\$DOCKERPASS\"
  - docker push udienz/buildpack:$x" >> $OUT
done
echo "
openmerge:
    image: udienz/gitlab-merge-resource
    before_script: []
    stage: deploy
    except:
        refs:
            - master
    script:
        - HOST=\${CI_PROJECT_URL} CI_PROJECT_ID=\${CI_PROJECT_ID} CI_COMMIT_REF_NAME=\${CI_COMMIT_REF_NAME} GITLAB_USER_ID=\${GITLAB_USER_ID} PRIVATE_TOKEN=\${GITLAB_PRIVATE_TOKEN} \$CI_PROJECT_DIR/utils/merge.sh
    when: on_success

build-latest:
 stage: build
 except:
  refs:
   - master
 script:
  - docker build -t buildpack-latest \$CI_PROJECT_DIR/bionic
  - docker tag buildpack-latest udienz/buildpack:latest
  - docker login -u=\"\$DOCKERUSER\" -p=\"\$DOCKERPASS\"
  - docker push udienz/buildpack:latest" >> $OUT
