#!/bin/bash

echo `git show --format="%h" HEAD | head -1` > build_info.txt
echo `git rev-parse --abbrev-ref HEAD` >> build_info.txt

docker build -t $USER_NAME/ui:1.0 ./ui
docker build -t $USER_NAME//post-py:1.0 ./post-py
docker build -t $USER_NAME/comment:1.0 ./comment
