#!/bin/bash

# might want to try the lighter version of nginx
apt -y install nginx

# configure nginx
cp /etc/irods_client_rest_cpp/irods_client_rest_cpp_reverse_proxy.conf.template /etc/nginx/sites-available/irods_client_rest_cpp_reverse_proxy.conf
ln -s /etc/nginx/sites-available/irods_client_rest_cpp_reverse_proxy.conf /etc/nginx/sites-enabled/irods_client_rest_cpp_reverse_proxy.conf
rm /etc/nginx/sites-enabled/default

# configure rsyslog
cp /etc/irods_client_rest_cpp/irods_client_rest_cpp.conf.rsyslog /etc/rsyslog.d/00-irods_client_rest_cpp.conf
cp /etc/irods_client_rest_cpp/irods_client_rest_cpp.logrotate /etc/logrotate.d/irods_client_rest_cpp

# configure REST API
REST_CLIENT_CONFIG=${REST_CLIENT_CONFIG-/etc/irods_client_rest_cpp/irods_client_rest_cpp.json}
cp /etc/irods_client_rest_cpp/irods_client_rest_cpp.json.template $REST_CLIENT_CONFIG
chmod 600 $REST_CLIENT_CONFIG
sed -i "s/[[:space:]]*\"zone\":[[:space:]]*\"tempZone\",[[:space:]]*/        \"zone\": \"$IRODS_SERVER_ZONE_NAME\",/" $REST_CLIENT_CONFIG
sed -i "s/[[:space:]]*\"port\":[[:space:]]*1247,[[:space:]]*/        \"port\": $IRODS_SERVER_PORT,/" $REST_CLIENT_CONFIG
sed -i "s/[[:space:]]*\"rodsadmin_username\":[[:space:]]*\"rods\",[[:space:]]*/        \"rodsadmin_username\": \"$IRODS_SERVER_ADMIN_USERNAME\",/" $REST_CLIENT_CONFIG
sed -i "s/[[:space:]]*\"rodsadmin_password\":[[:space:]]*\"rods\",[[:space:]]*/        \"rodsadmin_password\": \"$IRODS_SERVER_ADMIN_PASSWORD\",/" $REST_CLIENT_CONFIG
sed -i "s/[[:space:]]*\"default_resource\":[[:space:]]*\"demoResc\"[[:space:]]*/        \"default_resource\": \"$IRODS_DEFAULT_RESOURCE\"/" $REST_CLIENT_CONFIG
