#!/bin/bash

CONTAINER='tinymeteor'

set -e

TMPDIR=$(mktemp -d)
trap "rm -rf ${TMPDIR}" EXIT

# Figure out the docker tag we're using by looking at the branch
TAG=$(echo ${CI_BUILD_REF_NAME} | sed 's/release\/v//' | sed 's/feature\///')

ARCHIVE=${CONTAINER}_${TAG}.tgz
S3_ARCHIVE=${AWS_BUCKET}/${ARCHIVE}

# Make a temp folder and change to that directory
pushd ${TMPDIR}

# Tag the docker image
echo "Tagging the image as ${CONTAINER}:${TAG}"
docker tag ${CONTAINER}:latest ${CONTAINER}:${TAG}

# Save the docker image to an archive
echo "Archiving to ${ARCHIVE}"
docker save ${CONTAINER}:${TAG} | gzip -c > ./${ARCHIVE}

# Upload the archive to s3
echo "Uploading ${ARCHIVE} to S3"
docker run \
    --rm \
    -v /etc/gitlab-runner/.aws:/root/.aws:ro \
    -v $(pwd):/tmp/archive \
    anigeo/awscli s3 cp /tmp/archive/${ARCHIVE} ${S3_ARCHIVE}

echo "Done"
popd
