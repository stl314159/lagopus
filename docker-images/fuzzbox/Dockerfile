# Sets up a Docker image with Grafana, InfluxDB and AFL
# Grafana will monitor AFL's fuzzing progress and is accessible on port 3000

FROM aflplusplus/aflplusplus:latest as base

# # Basic setup & tools
# RUN echo 'debconf debconf/frontend select Noninteractive' | debconf-set-selections && \
#     apt-get update && \
#     apt-get install -y \
#       curl \
#       wget \
#       gpg \
#       apt-transport-https \
#       lsb-release \
#       software-properties-common \
#       gdb

# dependencies setup
RUN mkdir /opt/aflbox/
# RUN cd /opt/aflbox/ && git clone https://gitlab.com/rc0r/afl-utils.git
# COPY ./afl-utils /opt/aflbox/afl-utils
COPY ./setup-ubuntu.sh /opt/aflbox/
RUN cd /opt/aflbox/ && /opt/aflbox/setup-ubuntu.sh

COPY entrypoint.sh /opt/entrypoint.sh
ENTRYPOINT [ "/opt/entrypoint.sh" ]
