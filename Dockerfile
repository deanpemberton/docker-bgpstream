FROM ubuntu
MAINTAINER Dean Pemberton

WORKDIR /tmp
RUN apt-get update && apt-get install -y wget build-essential  zlib1g-dev libbz2-dev libcurl4-openssl-dev && rm -rf /var/lib/apt/lists/*
RUN wget http://research.wand.net.nz/software/wandio/wandio-1.0.3.tar.gz
RUN tar xvzf wandio-1.0.3.tar.gz
RUN cd wandio-1.0.3 && ./configure --prefix=/usr &&  make && make install  && ldconfig
WORKDIR /tmp
RUN wget http://bgpstream.caida.org/bundles/caidabgpstreamwebhomepage/dists/bgpstream-1.1.0.tar.gz
RUN tar xvzf bgpstream-1.1.0.tar.gz
RUN cd bgpstream-1.1.0 && ./configure --prefix=/usr &&  make && make check && make install && ldconfig
WORKDIR /data

ENTRYPOINT ["bgpreader"]
CMD ["--help"]
