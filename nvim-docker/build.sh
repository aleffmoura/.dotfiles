#!/bin/zsh

# GET DATE IN yyyymmddHHmmss FORMAT
export BUILD_DATE=$(date +%Y%m%d%H%M%S)

docker-compose build

 # DO YOU WANT TO PUSH THE IMAGE?
read -q "REPLY?Do you want to push the image? [y/N] "
if [[ $REPLY =~ ^[Yy]$ ]]
then
		docker-compose push
fi

