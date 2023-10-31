#!/bin/bash
docker run --network host -it haoxingxing/zjuhpc01 

docker run --network host -it haoxingxing/zjuhpc01 bash


ssh-keygen
echo -e "Host *\n\tStrictHostKeyChecking no\n\n" > ~/.ssh/config
sshpass -p ZJUMPILAB! ssh-copy-id root@node

echo "192.168.0.7 slots=1
192.168.0.6 slots=1
192.168.0.5 slots=1
192.168.0.4 slots=1
" > hosts
export OMPI_ALLOW_RUN_AS_ROOT=1
export OMPI_ALLOW_RUN_AS_ROOT_CONFIRM=1

/app/mpi/bin/mpirun --hostfile hosts uptime
/app/mpi/bin/mpirun --hostfile hosts -wdir /app/hpl-2.3/bin/Linux_HPC/ /app/hpl-2.3/bin/Linux_HPC/xhpl