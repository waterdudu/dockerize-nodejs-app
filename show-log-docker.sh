#!/bin/bash

docker logs $(docker ps -a | grep -v 'CONTAINER' | grep node-docker-app | awk '{print $1}')
