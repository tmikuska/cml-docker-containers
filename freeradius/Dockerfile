FROM debian:bookworm-slim

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && \
  apt-get upgrade -y && \
  apt-get install -y --no-install-recommends freeradius && \
  apt-get clean && \
  rm -rf /var/lib/apt/lists/*

RUN mv /etc/freeradius/3.0/radiusd.conf /etc/freeradius/3.0/radiusd.conf-original && \
  mv /etc/freeradius/3.0/clients.conf /etc/freeradius/3.0/clients.conf-original && \
  mv /etc/freeradius/3.0/mods-config/files/authorize /etc/freeradius/3.0/mods-config/files/authorize-original

COPY radiusd.conf /etc/freeradius/3.0/radiusd.conf
COPY clients.conf /etc/freeradius/3.0/clients.conf
COPY users /etc/freeradius/3.0/mods-config/files/authorize

EXPOSE 1812/udp
EXPOSE 1813/udp

CMD ["freeradius", "-f", "-lstdout"]

