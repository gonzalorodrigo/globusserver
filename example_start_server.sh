#!/bin/bash
export GLOBUS_USER="globus_user_witho_@globusid.org"
export GLOBUS_PASSWORD="globus_password"
export SHORT_HOSTNAME="thehostname"
export PUBLIC_HOSTNAME="thehostname.domain.org"
export GLOBUS_ACTIVATE_USER="activate_user"
export GLOBUS_ACTIVATE_PASSWORD="activate_password"
export DOMAIN_NAME="domain.org"
export GLOBUS_DATA_DIR="./data"
export GLOBUS_PERSISTENT=1

docker-compose build
docker-compose up
