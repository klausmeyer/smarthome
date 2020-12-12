#!/bin/sh

set -e

for file in $(ls -1 docker-stacks)
do
  echo "--------------------------------------------------------------------------------"
  echo "- Stack: $file "
  echo "--------------------------------------------------------------------------------"
  docker stack deploy -c docker-stacks/$file smarthome
done
