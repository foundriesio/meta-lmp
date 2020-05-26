#!/bin/sh
#
# LMP has a read-only rootfs, so we can't execute ptest-runner directly
# as most test cases expect to be able to write data to the disk.
#
# As a workaround, copy over all ptests available at /usr/lib into a
# writable directory, and use that as reference with ptest-runner.

set -e

# List of ptests to run, separated by spaces (empty means all)
PTESTS=${PTESTS}

PTEST_DIR=${HOME}/ptests
rm -fr ${PTEST_DIR}

# Tests are available under /usr/lib/<package>/ptest
find /usr/lib -name run-ptest | while read pkg; do
	pkg_path=$(echo ${pkg} | sed -e "s/\/ptest\/run-ptest//")
	ptest=$(basename ${pkg_path})
	mkdir -p ${PTEST_DIR}/${ptest}/
	cp -r ${pkg_path}/ptest/ ${PTEST_DIR}/${ptest}/
done

# Print available tests before executing them
ptest-runner -d ${PTEST_DIR} -l

# Run desired ptests
echo
if [ -n "${PTESTS}" ]; then
	echo "Running ptests: ${PTESTS}"
else
	echo "Running all ptests available at ${PTEST_DIR}"
fi
echo

ptest-runner -x ptest-run.xml -d ${PTEST_DIR} ${PTESTS}
