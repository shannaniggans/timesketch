#!/bin/bash
#
# Script to run tests on Travis-CI.
#
# This file is generated by l2tdevtools update-dependencies.py, any dependency
# related changes should be made in dependencies.ini.

# Exit on error.
set -e;

if test -n "${UBUNTU_VERSION}";
then
	CONTAINER_NAME="ubuntu${UBUNTU_VERSION}";

	if test "${TARGET}" = "pylint";
	then
		TEST_COMMAND="./config/travis/run_pylint.sh";

	elif test ${TRAVIS_PYTHON_VERSION} = "2.7";
	then
		TEST_COMMAND="nosetests";
	else
		TEST_COMMAND="nosetests3";
	fi
	docker exec ${CONTAINER_NAME} sh -c "export LANG=en_US.UTF-8; cd timesketch && ${TEST_COMMAND}";

elif test "${TRAVIS_OS_NAME}" = "linux";
then
	python ./run_tests.py --full

	yarn run build
fi
