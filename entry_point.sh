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

globus_state_file_name="globus_state.tar.gz"
globus_state_dir="/globus_state"
globus_state_file="${globus_state_dir}/${globus_state_file_name}"

echo "Creating activation user"
useradd -ms /bin/bash "${GLOBUS_ACTIVATE_USER}"
echo ""${GLOBUS_ACTIVATE_USER}":"${GLOBUS_ACTIVATE_PASSWORD}"" | chpasswd
echo "Configuring globus"
if [ "$GLOBUS_CREATE_STATE_COPY" != 1 ] &&  [ -f "$globus_state_file" ]
then
  echo "Restoring Globus state"
  tar -xvzf "${globus_state_file}"
fi
globus-connect-server-setup
if [ "$GLOBUS_CREATE_STATE_COPY" = 1 ]
then
  echo "Making copy of globus state, copying into ${globus_state_file}"
  tar -cvzf "${globus_state_file}" /var/lib/globus  \
/var/lib/globus-connect-server /var/lib/myproxy /var/lib/myproxy-oauth
fi
echo "All done... Server running"
sleep infinity
