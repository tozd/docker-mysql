#!/bin/sh

set -e

cleanup() {
  set +e

  echo "Logs"
  docker logs test

  echo "MySQL log"
  docker cp test:/var/log/mysql/error.log - | tar -xO | tail -n 30

  echo "Stopping Docker image"
  docker stop test
  docker rm -f test
}

echo "Running Docker image"
docker run -d --name test -p 3306:3306 "${CI_REGISTRY_IMAGE}:${TAG}"
trap cleanup EXIT

echo "Sleeping"
sleep 20

echo "Testing"
nc -z docker 3306

echo "Testing clean shutdown"
# A server which does not stop on its own is killed by Docker once the timeout passes, which shows as exit code 137.
docker stop -t 60 test
if [ "$(docker inspect --format '{{.State.ExitCode}}' test)" != "0" ]; then
  echo "Container did not stop cleanly"
  exit 1
fi
if ! docker cp test:/var/log/mysql/error.log - | tar -xO | grep -q "Shutdown complete"; then
  echo "MySQL did not log a clean shutdown"
  exit 1
fi
echo "Success"
