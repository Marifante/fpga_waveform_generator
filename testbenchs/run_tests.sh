#!/bin/bash

echo "
FPGA Waveform Generator tests

"

TESTBENCH_TO_EXECUTE="all"
MAKE_TARGET=''

while getopts "o:c" opt; do
	case ${opt} in
	o)
		TESTBENCH_TO_EXECUTE=${OPTARG}
		echo "Executing only ${TESTBENCH_TO_EXECUTE}"
		#		break
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

## This function can be used to check if a testbench failed, parsing the results.xml file
## will exit if a failure has been found!
check_if_testbench_failed() {
	readarray -t RESULTS_PATHS < <(find $1 -name 'results.xml')
	for results_path in "${RESULTS_PATHS[@]}"; do
		if grep -q "<failure />" ${results_path}; then
			echo "errors found in ${results_path}"
			exit -1
		fi
	done
}

echo "date: $(date)"
if [[ ${TESTBENCH_TO_EXECUTE} == 'all' ]]; then
	## Run the testbenchs and exits with error code if any one have a failure!
	echo "running all the testbenchs!"
	readarray -t TESTS_PATHS < <(find $(pwd) -name 'Makefile')
	echo "Makefiles found: ${TESTS_PATHS[@]}"

	for makefile_path in "${TESTS_PATHS[@]}"; do
		path=${makefile_path%/Makefile}
		echo "=================================================================================================="
		(echo "going to $path" && cd "$path" && make clean && make && check_if_testbench_failed "$path")
		if [ $? -ne 0 ]; then
			echo "this testbench failed! exiting with error code..."
			exit -1
		fi
		echo "=================================================================================================="
	done
else
	echo "running only ${TESTBENCH_TO_EXECUTE} testbench!"
	echo "=================================================================================================="
	(echo "going to ${TESTBENCH_TO_EXECUTE}" && cd "${TESTBENCH_TO_EXECUTE}" && make clean && make)
	echo "=================================================================================================="
fi

echo "=================================================================================================="
echo "== All the tests finished!! Ciao!"
echo "=================================================================================================="
