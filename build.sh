#!/bin/sh

set -e

for image in $(ls -1 images)
do
  echo "--------------------------------------------------------------------------------"
  echo "- Image: $image "
  echo "--------------------------------------------------------------------------------"

  image=$(echo "$image" | tr "_" "-")

  docker build -t 127.0.0.1:5000/smarthome/$image images/$image
  docker push 127.0.0.1:5000/smarthome/$image
done

