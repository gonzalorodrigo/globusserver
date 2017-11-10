#!/bin/bash
#
# Entry point to start a Globus Connect Server
# Requires that the following en vars are set:
#
# GLOBUS_USER user of a valid globus credential to associate the connect server
#  to.
# GLOBUS_PASSWORD password of that credentional.
# SHORT_HOSTNAME last part hostname of the server.
# HOSTNAME full hostname (including domain)
# GLOBUS_ACTIVATE_USER username with loing permissions in the machine where
#  the server runs.
# GLOBUS_ACTIVATE_PASSWORD password of the GLOBUS_ACTIVATE_USER.

echo "Creating activation user"
useradd -ms /bin/bash "${GLOBUS_ACTIVATE_USER}"
echo ""${GLOBUS_ACTIVATE_USER}":"${GLOBUS_ACTIVATE_PASSWORD}"" | chpasswd
echo "Configuring globus"
globus-connect-server-setup
sleep infinity
