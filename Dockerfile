FROM python:2.7.14-jessie

RUN curl -LOs https://downloads.globus.org/toolkit/globus-connect-server/globus-connect-server-repo_latest_all.deb
RUN dpkg -i globus-connect-server-repo_latest_all.deb
RUN apt-get update
RUN apt-get -y install ntp
RUN mkdir -p /var/lib/globus/simple_ca
RUN apt-get -y install globus-connect-server

RUN mkdir -p /globus_state
ARG GUEST_GLOBUS_DATA_DIR
RUN mkdir -p ${GUEST_GLOBUS_DATA_DIR}
ENV TERM xterm
ADD ./entry_point.sh .
ADD ./globus-connect-server.conf /etc/.
