#!/bin/sh

set -e

cleanup() {
  echo "Stopping Docker image"
  docker stop test
}

echo "Running Docker image"
docker run -d --name test --rm -p 3306:3306 "${CI_REGISTRY_IMAGE}:${TAG}"
trap cleanup EXIT

echo "Sleeping"
sleep 10

echo "Testing"
nc -z docker 3306
