FROM ubuntu:18.04

COPY gcc-8 /work/gcc-8
COPY pqxx /work/pqxx
COPY deps.sh /work/deps.sh

RUN chsh -s /bin/bash && \
    DEBIAN_FRONTEND=noninteractive apt-get update -y && \
    DEBIAN_FRONTEND=noninteractive apt-get -y dist-upgrade && \
    DEBIAN_FRONTEND=noninteractive bash /work/deps.sh && \
    DEBIAN_FRONTEND=noninteractive bash /work/gcc-8/install.sh && \
    DEBIAN_FRONTEND=noninteractive bash /work/pqxx/install.sh && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

