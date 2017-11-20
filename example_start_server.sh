#!/bin/bash
#
# Example script to run globus connect server.
#

export GLOBUS_USER="globus_user_witho_@globusid.org"
export GLOBUS_PASSWORD="globus_password"
export SHORT_HOSTNAME="thehostname"
export PUBLIC_HOSTNAME="thehostname.domain.org"
export DOMAIN_NAME="domain.org"
export GLOBUS_ACTIVATE_USER="activate_user"
export GLOBUS_ACTIVATE_PASSWORD="activate_password"
export HOST_GLOBUS_DATA_DIR="./data"
export GUEST_GLOBUS_DATA_DIR="/data"
export GLOBUS_PERSISTENT=1

if [ -z ${PUBLIC_IP} ]; then
  export PUBLIC_IP=`dig +short $PUBLIC_HOSTNAME`
  echo "PUBLIC_IP not set, setting IP to ${PUBLIC_IP}"
fi

if [ -z ${GRIDFTP_IP} ]; then
  export GRIDFTP_IP=${PUBLIC_IP}
  echo "GRIDFTP_IP not set, setting IP to ${GRIDFTP_IP}"
fi

docker-compose build
docker-compose up -d
