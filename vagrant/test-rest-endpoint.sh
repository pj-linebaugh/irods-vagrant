#!/bin/bash

source /vagrant/active-irods-variables.sh

export SECRETS=$(echo -n $IRODS_SERVER_ADMIN_USERNAME:$IRODS_SERVER_ADMIN_PASSWORD | base64)
echo "SECRETS: $SECRETS"
export TOKEN=$(curl -s -X POST -H "Authorization: Basic ${SECRETS}" http://localhost:80/irods-rest/0.9.3/auth)
echo "TOKEN: $TOKEN"

echo "## test query"
curl -s -X GET -H "Authorization: ${TOKEN}" 'http://localhost/irods-rest/0.9.3/query?limit=100&offset=0&type=general&query=SELECT%20COLL_NAME%2C%20DATA_NAME%20WHERE%20COLL_NAME%20LIKE%20%27%2FtempZone%2Fhome%2Frods%25%27' | jq
echo "## test list"
curl -s -X GET -H "Authorization: ${TOKEN}" 'http://localhost/irods-rest/0.9.3/list?logical-path=%2FtempZone%2Fhome%2Frods&stat=0&permissions=0&metadata=0&offset=0&limit=100' | jq