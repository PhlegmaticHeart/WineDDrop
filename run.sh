#!/bin/bash

set -e

IMAGE_NAME="wineddrop"
TAG="latest"
PLATFORM=$(docker info --format '{{.Architecture}}')  # Auto-detect

case $1 in

"create" )

echo 'creating '$IMAGE_NAME' container'

docker run \
  -it \
  --name ''$IMAGE_NAME'_container' \
  --privileged \
  --network=host \
  --device /dev/snd \
  --device /dev/dri:/dev/dri \
  --group-add video \
  --group-add render \
  --group-add audio \
  -e ALSA_CARD=Generic \
  -e PULSE_SERVER=unix:${XDG_RUNTIME_DIR}/pulse/native \
  -e WINE_LARGE_ADDRESS_AWARE=1 \
  -e DISPLAY=$DISPLAY \
  -e XAUTHORITY=/root/.Xauthority \
  -v ${XDG_RUNTIME_DIR}/pulse/native:${XDG_RUNTIME_DIR}/pulse/native \
  -v ~/.config/pulse/cookie:/root/.config/pulse/cookie \
  -v /tmp/.X11-unix:/tmp/.X11-unix \
  -v ~/.Xauthority:/root/.Xauthority \
  -v /home/$USER:/home/admin/bench \
  -v /media:/media \
  -v lutris_prefixes:/home/admin/Games \
  --mount type=bind,source=$PWD/entrypoint.sh,target=/usr/bin/entrypoint.sh \
  --entrypoint /usr/bin/entrypoint.sh \
  --ipc=host \
  "$IMAGE_NAME:$TAG" 
;;

"start" )

echo 'starting '$IMAGE_NAME''
docker start -ai ''$IMAGE_NAME'_container'
;;

"new_shell" )

echo 'creating new shell of '$IMAGE_NAME'_container'
docker exec -it ''$IMAGE_NAME'_container' /bin/bash
;;

"attach" )

echo 'attaching to '$IMAGE_NAME'_container'
docker attach ''$IMAGE_NAME'_container'
;;

"stop" )

echo 'stopping '$IMAGE_NAME''
docker stop ''$IMAGE_NAME'_container'
echo 'stopped'

;;

"remove" )

echo 'removing '$IMAGE_NAME'_container'
docker container rm --force ''$IMAGE_NAME'_container'
echo 'removed'
;;

* )

echo '|||| SCRIPT USAGE ||||'
echo './run.sh [ARGUMENT]   '
echo '|Entries:             '
echo ' '
echo '- create              '
echo 'Creates the container.'
echo ' '
echo '- start               '
echo 'Starts the container. '
echo 'and attach to it.     '
echo ' '
echo '- new_shell           '
echo 'Creates a new shell   '
echo 'inside the container  '
echo 'do this if you need   '
echo 'more terminals.       '
echo ' '
echo '- attach              '
echo 'Attaches to the         '
echo 'container shell.            '
echo ' '
echo '- stop                '
echo 'stops the container.  '
echo ' '
echo '- remove              '
echo 'removes the container.'
;;

esac
