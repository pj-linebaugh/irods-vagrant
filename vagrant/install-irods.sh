#!/bin/bash

# setup iRODS package repository
wget -qO - https://packages.irods.org/irods-signing-key.asc | apt-key add -
echo "deb [arch=amd64] https://packages.irods.org/apt/ $(lsb_release -sc) main" | tee /etc/apt/sources.list.d/renci-irods.list  

# update local repo cache to include the irods repo
apt-get update

# install iRODS
apt-get install -y irods-server irods-database-plugin-postgres
