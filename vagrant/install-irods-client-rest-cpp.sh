#!/bin/bash

apt install -y irods-client-rest-cpp nginx jq

# This is a patch for the iRODS (4.3.0-1~focal) init script to set the HOME variable.
IRODS_CLIENT_REST_CPP_INIT_PATCH=${IRODS_CLIENT_REST_CPP_INIT_PATCH-/vagrant/etc-init.d-irods_client_rest_cpp.patch}
patch /etc/init.d/irods_client_rest_cpp $IRODS_CLIENT_REST_CPP_INIT_PATCH
