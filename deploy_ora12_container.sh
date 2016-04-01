#!/bin/bash

#./deploy_ora12_container.sh -v -s -u

build_docker_image() {
	DOCKER_IMAGE=$1
	if [ "$(docker images -q $DOCKER_IMAGE)" == "" ]
	then
		echo "Building image $DOCKER_IMAGE...."
		docker build --file ./Dockerfile-$DOCKER_IMAGE -t $DOCKER_IMAGE .
	else
		echo "Docker image $DOCKER_IMAGE is already built"
	fi
}

init_volume_directory() {
	if [ "$VOLUME" == "YES" ]; then
		echo "Initializing volume directory ${VOLUME_DIR}"
		echo "Any existing contents will be removed"
		sudo rm -rf ${VOLUME_DIR}
	    sudo mkdir -p ${VOLUME_DIR}
	    sudo chown 54321:54321 ${VOLUME_DIR}
	fi
}

# Use > 1 to consume two arguments per pass in the loop (e.g. each
# argument has a corresponding value to go with it).
# Use > 0 to consume one or more arguments per pass in the loop (e.g.
# some arguments don't have a corresponding value to go with it such
# as in the --volume example).
while [[ $# > 0 ]]
do
key="$1"

case $key in
    -s|--start)
    START_CONTAINER=YES
#    shift
    ;;
    -h|--hostname)
    CONTAINER_HOSTNAME="$2"
    shift # past argument
    ;;
    -v|--volume)
    VOLUME=YES
    ;;
    -u|--utp)
    INSTALL_UTP=YES
    ;;

    *)
            # unknown option
    ;;
esac
shift # past argument or value
done

VOLUME_DIR="/home/seb/db/sebora12"

echo "*********************************************"
echo START CONTAINER = "${START_CONTAINER}"
echo CONTAINER HOSTNAME = "${CONTAINER_HOSTNAME}"
echo VOLUME DIRECTORY INIT = "${VOLUME}"
echo VOLUME DIRECTORY = "${VOLUME_DIR}"
echo INSTALL UTP = "${INSTALL_UTP}"
echo "*********************************************"

build_docker_image ora-deps
build_docker_image oradb:12

echo "*********************************************"
init_volume_directory

echo "*********************************************"
if [ "${START_CONTAINER}" == "YES" ]; then
	if  [ -z "${CONTAINER_HOSTNAME+x}" ]; then
		echo "The container hostname has not been specified"
		CONTAINER_HOSTNAME=sebora12
		echo "The container hostname defaulted to ${CONTAINER_HOSTNAME} "
	fi
	echo "Starting container..."
	date
    docker run --ipc=host --volume=${VOLUME_DIR}:/u01/app/oracle/data --name ${CONTAINER_HOSTNAME} --hostname ${CONTAINER_HOSTNAME} --detach=true --publish=1521:1521 oradb:12
    while [ ! -f ${VOLUME_DIR}/DATABASE_IS_SETUP ]
	do
		sleep 80
		echo "Waiting for database installation to complete......"
 	done
    date
fi

echo "*********************************************"
if [ "${INSTALL_UTP}" == "YES" ]; then
    docker exec ${CONTAINER_HOSTNAME} bash -l install-utp.sh
    date
fi