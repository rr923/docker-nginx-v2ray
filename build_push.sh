#!/bin/bash

if [ $# -ne 2 ]; then
  echo "Command error, format should look like: ./build id tag, such as ./build abc v1.0, then docker image 'abc/nginx-v2ray:v1.0' will be created and pushed to docker hub."
  exit 1
fi

IMAGE="$1/nginx-v2ray:$2"

docker build -t "$IMAGE" .

if [ $? -ne 0 ]; then
  echo "Error: image build failed, push skipped."
  exit 1
fi

docker push "$IMAGE"

if [ $? -ne 0 ]; then
  echo "Error: image push failed, make sure you run 'docker login -u username' if needed."
  exit 1
fi

echo
echo "Succeed: $IMAGE created and pushed to docker hub"
