

  # DOCKER
  
  ### Docker build
  ```bash
    docker build -t a4i3ia2 .
    geth -identity "a4i3ia2" init "CustomGenesis.json" -datadir "externalDataDir"  
    docker run -p 8055:8055 -p 55555:55555 -v path/to/externalDataDir:/opt/blockchain/datadir -i -t a4i3ia2:latest
    # Wait the ethereum node synchronization.
  ```
  
  ### Connection to enode
  ```bash
    geth attach http://localhost:8055
  ```
  