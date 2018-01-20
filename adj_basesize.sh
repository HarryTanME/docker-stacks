#!/bin/bash

set -e



echo ECS_CLUSTER=name >> /etc/ecs/ecs.config



echo 'OPTIONS="${OPTIONS} --storage-opt dm.basesize=20G"' >> /etc/sysconfig/docker

/etc/init.d/docker restart
