#!/bin/bash
docker run --network host -it haoxingxing/zjuhpc01 

docker run --network host -it haoxingxing/zjuhpc01 bash


ssh-keygen
echo -e "Host *\n\tStrictHostKeyChecking no\n\n" > ~/.ssh/config
sshpass -p ZJUMPILAB! ssh-copy-id root@node

echo "192.168.0.22 slots=1
192.168.0.21 slots=1
192.168.0.20 slots=1
192.168.0.19 slots=1
" > hosts
export OMPI_ALLOW_RUN_AS_ROOT=1
export OMPI_ALLOW_RUN_AS_ROOT_CONFIRM=1

mpirun --hostfile hosts uptime