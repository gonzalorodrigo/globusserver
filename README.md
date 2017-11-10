# Container of a Globus Connect Server

This container will deploy a Globus Connect Server associated with GLOBUS_USER
annd will use GLOBUS_ACTIVATE_USER as the activation user from the Globus
central system (Activation must done in the control panel of GLOBUS_USER
in the Globus website).

# Deployment

Server requires a number of environment vars to be set before running.

## Enviroment vars

# GLOBUS_USER GLOBUS_PASSWORD

These are the username and password of the globus account to which this server
will associate.

# HOSTNAME SHORT_HOSTNAME DOMAIN_NAME

They capture the hostname of the new Globus connect server. For example
if the server full hostname is "myserver.mydomain.com", these variables
should be set to:

~~~
HOSTNAME="myserver.mydomain.com"
SHORT_HOSTNAME="myserver"
DOMAIN_NAME="mydomain.com"
~~~
This info must be valid and corresponding to the DNS information of the server.
# GLOBUS_ACTIVATE_USER GLOBUS_ACTIVATE_PASSWORD

In order to vinculate the server to a globus account, the globus account
must prove that has an account in that server. GLOBUS_ACTIVATE_USER,
GLOBUS_ACTIVATE_PASSWORD are used to create a user in the Server
to then use it in the activation process. The concrete values are irrelevant
as long as the same credentials are used in the activation.

For more details read the [globus docs](https://docs.globus.org/globus-connect-server-installation-guide/).

## Deployment example
~~~
export GLOBUS_USER="a_globus_user"
export GLOBUS_PASSWORD="the_globus_password"
export SHORT_HOSTNAME="server_hostname"
export HOSTNAME="server_hostname.mydomain.com"
export DOMAIN_NAME="mydomain.com""
export GLOBUS_ACTIVATE_USER="user_to_activate"
export GLOBUS_ACTIVATE_PASSWORD="password_to_activate"

docker-compose up
~~~
