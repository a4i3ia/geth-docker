FROM ubuntu:16.04

RUN apt-get update
RUN apt-get install -y build-essential

RUN mkdir /opt/blockchain && \
    mkdir /opt/blockchain/datadir && \
    mkdir /etc/my_init.d

RUN apt-get update
RUN apt-get install -y supervisor git make wget

# Create the custom increase of difficulty
RUN cd /opt/blockchain && git clone https://github.com/ethereum/go-ethereum
RUN sed -i 's/return CalcDifficulty(chain.Config(), time, parent)/return big.NewInt(1)/g' \
    /opt/blockchain/go-ethereum/consensus/ethash/consensus.go

# Configure golang as the 1.10 version
RUN cd /opt/blockchain && \
    wget https://dl.google.com/go/go1.10.linux-amd64.tar.gz && \
    tar -xvf go1.10.linux-amd64.tar.gz && \
    mv go /usr/local && \
    rm -rf go1.10.linux-amd64.tar.gz
ENV GOROOT /usr/local/go
ENV GOPATH $HOME/Projects/ADMFactory/Golang
ENV PATH $GOPATH/bin:$GOROOT/bin:$PATH

RUN cd /opt/blockchain/go-ethereum && make geth
RUN mv /opt/blockchain/go-ethereum/build/bin/geth /usr/bin

COPY  CustomGenesis.json /opt/blockchain/CustomGenesis.json

RUN geth -identity "a4i3ia2" init "/opt/blockchain/CustomGenesis.json" -datadir "/opt/blockchain/datadir"
RUN chmod 777 -R /opt/blockchain/datadir

COPY  a4i3ia2.conf /etc/supervisor/conf.d/a4i3ia2.conf

COPY  autostart.sh /etc/my_init.d/autostart.sh
RUN chmod +x /etc/my_init.d/autostart.sh
#RUN echo "log..." > /var/log/supervisor/geth.err.log
#RUN chmod 777 /var/log/supervisor/geth.err.log
CMD /etc/my_init.d/autostart.sh && tail -f /var/log/supervisor/geth.err.log
EXPOSE 8055 55555

WORKDIR /opt/blockchain/
