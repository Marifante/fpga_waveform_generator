#!/bin/bash

###############################################################################
## Function

log() {
	echo "$(date +"%Y-%m-%dT%H:%M:%S.%03N") - $*"
}

###############################################################################
## Parameters
DOCKER_IMAGE_EXECUTED_LOCALLY='fpga_waveform_generator_testbenchs:local'
REBUILD_IMAGE=false

while getopts "r" opt; do
	case ${opt} in
	r)
		REBUILD_IMAGE=true
		;;
	\?)
		echo "Invalid option: -$OPTARG"
		exit 1
		;;
	:)
		echo "The option -$OPTARG requires an argument."
		exit 1
		;;
	esac
done

if [ "$(arch)" = "x86_64" ]; then
	ARCH=amd64
else
	log_error "Platform not supported: $(arch)"
	exit -1
fi

if [ "${REBUILD_IMAGE}" = "true" ]; then
	log "erasing ${DOCKER_IMAGE_EXECUTED_LOCALLY}..."
	docker rmi -f ${DOCKER_IMAGE_EXECUTED_LOCALLY}
fi

if [[ "$(docker images -q ${DOCKER_IMAGE_EXECUTED_LOCALLY} 2>/dev/null)" == "" ]]; then
	log "${DOCKER_IMAGE_EXECUTED_LOCALLY} do no exists! building it..."
	docker build -f ./.gci/Dockerfile -t ${DOCKER_IMAGE_EXECUTED_LOCALLY} --build-arg ARCH=${ARCH} .
else
	log "yeah! ${DOCKER_IMAGE_EXECUTED_LOCALLY} exists!!"
fi

docker run --rm -it -v $(pwd):/fpga_waveform_generator ${DOCKER_IMAGE_EXECUTED_LOCALLY} /bin/bash
