#!/bin/bash

function finish {
  # remove the exception from x11
  xhost -local:${CONTAINER_IP}
  echo -e "Removed ${CONTAINER_IP} from X11 allowed hosts"
}

trap finish EXIT

containername=ml-foundations-localx11
containerrunfile=/tmp/ml-foundations.run

# if the container is running, just output ip
if docker ps | grep -qE 'ml-foundations$'; then
    docker exec $containername /bin/bash -c "ip addr show eth0 | grep -Po 'inet \K[\d.]+' > /tmp/ml-foundations.run"
    
# if the container is stopped, start 
elif docker ps -a | grep -qE 'ml-foundations$'; then
    docker start $containername

# if the container doesn't exist, create it
else
    rm -f $containerrunfile
    touch $containerrunfile
    docker run -d \
    -e DISPLAY=$DISPLAY \
    -v /tmp/.X11-unix:/tmp/.X11-unix \
    -v ~/ml-foundations-workspace:/root/ml-foundations-workspace \
    -v $containerrunfile:/tmp/ml-foundations.run\
    --name $containername \
    ml-foundations /bin/bash -c "ip addr show eth0 | grep -Po 'inet \K[\d.]+' > /tmp/ml-foundations.run; while true; do sleep 1h; done"
fi

# add an exception to allow the container to use the local x11 server
CONTAINER_IP=$(cat $containerrunfile)
xhost +local:${CONTAINER_IP}
echo -e "Added ${CONTAINER_IP} to X11 allowed hosts"

# start a shell in the container
docker exec -it $containername /bin/bash
