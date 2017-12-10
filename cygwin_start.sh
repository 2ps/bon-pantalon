#!/bin/bash

trap '[ "$?" -eq 0 ] || read -p "Looks like something went wrong in step ´$STEP´... Press any key to continue..."' EXIT

docker_machine=${DOCKER_MACHINE-docker-machine.exe}
vm=2ps
local_dir="${LOCAL_DOCKER_DIR-c:\\x}"
home_dir="${HOME_DIR-/cygdrive/c/Users/`whoami`}"
docker_network="${DOCKER_NETWORK-2ps}"
disk_size=15000
ram_size=4000
echo "vm of interest is ${vm}"

BLUE='\033[1;34m'
GREEN='\033[0;32m'
NC='\033[0m'

function create_machine() {
    "${docker_machine}" create \
        -d virtualbox \
        --engine-opt bip="192.168.70.1/24" \
        --virtualbox-cpu-count=2 \
        --virtualbox-disk-size="${disk_size}" \
        --virtualbox-host-dns-resolver \
        --virtualbox-memory "${ram_size}" \
        --virtualbox-share-folder "${DOCKER_LOCAL_DIR}:/x" \
        --virtualbox-ui-type="gui" \
        "${vm}" ;
}

function start_machine() {
    machine_status=$("${docker_machine}" status "${vm}")
    if [ $? -eq 0 ] ; then
        echo "machine ${vm} exists"
        if [[ "${machine_status}" != "Running" ]]; then
            "${docker_machine}" start "${vm}"
        else
            echo "${vm} is running!"
        fi
    else
        echo "machine ${vm} does not exist!"
        create_machine
    fi 
}

function load_env() {
    eval $("${docker_machine}" env --shell=bash "${vm}")
    env | egrep '^(DOCKER|COMPOSE)'
}

function create_network() {
    docker network ls --filter "name=${docker_network}" | grep -i "${docker_network}" >/dev/null
    if [ $? -eq 0 ] ; then
        echo "docker network ${docker_network} found"
    else
        docker network create \
            --gateway "192.168.72.1" \
            --subnet "192.168.72.0/24" \
            --ip-range "192.168.72.2/24" \
            "${docker_network}"
    fi
}

start_machine
load_env
create_network

