## Container for Globus Connect Server

This container will deploy a Globus Connect Server associated with
GLOBUS_USER and will use GLOBUS_ACTIVATE_USER as the activation user from
Globus central system (Activation must done in the control panel of
GLOBUS_USER in the Globus website).

Every time that the server is re-deployed, it needs to be reactivated, this
can be avoided by giving persistance to some of the Globus files.

## Deployment

Server requires a number of environment vars to be set before running.
This variables can be set in the enviroment before starting the services
or in the .env file.

An example of how to set this variables is provided in the
example_start_server.sh file.


### Persistence

if env var GLOBUS_PERSISTENT is set to "1" and /globus_state mapped to a host
storage space, the server state will be stored upon graceful (SIGTERM,
SIGTINT) container stop.

Use "docker-compose down" for graceful stop.

### User config and host environment vars

#### Globus ID: GLOBUS_USER GLOBUS_PASSWORD

These are the username and password of the Globus account to which this
server will associate to. It is important that GLOBUS_USER does not
include the "@globusid.org" part.

#### Data folders: HOST_GLOBUS_DATA_DIR GUEST_GLOBUS_DATA_DIR

By default a folder (GUEST_GLOBUS_DATA_DIR) of the container is mapped on a
folder in the host system (HOST_GLOBUS_DATA_DIR). **This variables are needed
upon  build** Example:

~~~
export HOST_GLOBUS_DATA_DIR="./data"
export GUEST_GLOBUS_DATA_DIR="/data"
~~~

#### Hostnames and IPs: PUBLIC_HOSTNAME PUBLIC_IP SHORT_HOSTNAME DOMAIN_NAME GRIDFTP_IP

They capture the hostname of the new Globus connect server. For example
if the server full hostname is "myserver.mydomain.com", these variables
should be set to:

~~~
export PUBLIC_HOSTNAME="myserver.mydomain.com"
export SHORT_HOSTNAME="myserver"
export DOMAIN_NAME="mydomain.com"
export PUBLIC_IP=`dig +short $PUBLIC_HOSTNAME`
export GRIDFTP_IP=`dig +short $PUBLIC_HOSTNAME`
~~~
This info must be valid and corresponding to the DNS information of the
server.

In case that the control plane (MyProxy) and data plane (GridFTIP) relay
on different network interfaces (and IP addresses), the IP for GridFTP
(GRIDFTP_IP) can be set to be different to PUBLIC_IP.

#### Activation: GLOBUS_ACTIVATE_USER GLOBUS_ACTIVATE_PASSWORD

In order to link the server to a Globus account, the Globus account
must demonstrate that has an account in that server. GLOBUS_ACTIVATE_USER,
GLOBUS_ACTIVATE_PASSWORD are used to create a user in the Server
to then use it in the activation process. The concrete values are irrelevant
as long as the same credentials are used in the activation.

For more details read the [Globus docs](https://docs.globus.org/globus-connect-server-installation-guide/).

#### MTU
MTu of the network interface of the container can be set by exporting:
~~~
export MTU=9000
~~~
IMPORTANT: the Docker installation must be configured to accept large MTU values,
this is done by modifying the /etc/docker/daemon.json file, setting or adding the MTU
property:
~~~
{
  "mtu": 9000
}
~~~

### Deployment example
~~~
export GLOBUS_USER="globus_user_WITHOUT_@globusid.org"
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
docker-compose up
~~~
