# allows for X server connections that are needed for GUI apps
xhost +local:

docker run -it \
    --env="DISPLAY" \
    --env="QT_X11_NO_MITSHM=1" \
    --volume="/tmp/.X11-unix:/tmp/.X11-unix:rw" \
    --volume="/home/$(whoami)/work:/root/work:rw" \
    --device=/dev/dri:/dev/dri \
    --rm \
    naturo/kilobots
