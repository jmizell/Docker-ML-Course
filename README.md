A Dockerfile that provides a work environment for the Coursera course, Machine Learning Foundations.

## Build
  You will need a GraphLab license, which is free for academic, non-commercial use https://dato.com/learn/coursera/

```
  docker build \
  --build-arg GRAPHLABLIC=###SET_YOUR_LICENSE_KEY_HERE### \
  --build-arg GRAPHLABUSER=###SET_YOUR_REGISTER_EMAIL_ADDRESS_HERE### \
  -t ml-foundations \
  --force-rm .
```

## Run using vnc server
```
  docker run \
    -it \
    -v ~/ml-foundations-workspace:/root/ml-foundations-workspace \
    -p 127.0.0.1:5900:5900 \
    -e "VNC_RESOLUTION=1280x960" \
    ml-foundations

    vncviewer 127.0.0.1:5900
```

## Run using local x11 server
```
./start-local-x11.sh
```

  
