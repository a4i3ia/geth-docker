

  # DOCKER
  
  > Note: This container version is for testing only, because: <br>
    1. Due to very low difficulty the speed of mining is increased but the security of blockchain network is decreased. <br>
    2. Also in this container there are parameters to start geth, like targetgaslimit="1000000000000" or gasprice="0" which may be inappropriate for your setup.
  
  ### Docker build
  With external geth data dir.
  ```bash
    docker build -t speedster .
    geth -identity "speedster" init "CustomGenesis.json" -datadir "externalDataDir"  
    docker run -p 8055:8055 -p 55555:55555 -v path/to/externalDataDir:/opt/blockchain/datadir -i -t speedster:latest
    # Wait the ethereum node synchronization.
  ```
  
  Without external geth data dir.
  ```bash
      docker build -t speedster .
      docker run -p 8055:8055 -p 55555:55555 -i -t speedster:latest
      # Wait the ethereum node synchronization.
   ```
  
  ### Connection to enode
  ```bash
    geth attach http://localhost:8055
  ```
  