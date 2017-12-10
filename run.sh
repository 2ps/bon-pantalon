#!/usr/bin/env bash
x="${1}"
image_name=$(cat "${x}/NAME")
container_name="${2}"
if [ -n "${container_name}" ] ; then
    if docker ps -a | grep -i "${container_name}" >/dev/null ; then
        docker start -i "${container_name}"
    else
        docker run -it --name "${container_name}" -v /u:/u "${image_name}"
    fi
else
    docker run -it --rm -v /u:/u "${image_name}"
fi
