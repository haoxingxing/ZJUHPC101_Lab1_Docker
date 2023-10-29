#!/bin/bash
apt install sshpass

ssh-keygen

sshpass -p ZJUMPILAB! ssh-copy-id root@node