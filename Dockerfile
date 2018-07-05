FROM ubuntu:16.04

RUN apt-get update
RUN apt-get install -y build-essential

RUN mkdir /opt/blockchain && \
    mkdir /opt/blockchain/datadir && \
    mkdir /etc/my_init.d

RUN apt-get update
RUN apt-get install -y software-properties-common
RUN add-apt-repository -y ppa:ethereum/ethereum
RUN apt-get update
RUN apt-get install -y supervisor ethereum

COPY  CustomGenesis.json /opt/blockchain/CustomGenesis.json

RUN geth -identity "a4i3ia2" init "/opt/blockchain/CustomGenesis.json" -datadir "/opt/blockchain/datadir"
RUN chmod 777 -R /opt/blockchain/datadir

COPY  a4i3ia2.conf /etc/supervisor/conf.d/a4i3ia2.conf

COPY  autostart.sh /etc/my_init.d/autostart.sh
RUN chmod +x /etc/my_init.d/autostart.sh
CMD /etc/my_init.d/autostart.sh && tail -f /var/log/supervisor/geth.err.log
EXPOSE 8055 55555

WORKDIR /opt/blockchain/
