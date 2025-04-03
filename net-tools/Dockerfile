FROM debian:bookworm-slim

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && \
  apt-get upgrade -y && \
  apt-get install -y --no-install-recommends \
  bash iproute2 iputils-ping net-tools mtr-tiny iperf3 traceroute fping \
  sensible-utils curl telnet netcat-openbsd socat snmp termshark \
  openssh-client vim nano less jq yq httpie procps dnsutils && \
  apt-get clean && \
  rm -rf /var/lib/apt/lists/*

ENTRYPOINT [ "/bin/bash" ]

