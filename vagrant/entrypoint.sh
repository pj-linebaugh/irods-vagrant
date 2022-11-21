#!/bin/bash

source /vagrant/unattended_variables.sh

# Ensure postgresql service is running.
systemctl start postgresql
/vagrant/initialize-db-and-user.sh
/vagrant/configure-irods.sh
systemctl start irods

/vagrant/set-default-configuration-4-rest-client.sh
systemctl restart nginx
systemctl restart rsyslog
systemctl restart irods_client_rest_cpp
