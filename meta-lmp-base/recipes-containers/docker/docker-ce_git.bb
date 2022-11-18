HOMEPAGE = "http://www.docker.com"
SUMMARY = "Linux container runtime"
DESCRIPTION = "Linux container runtime \
 Docker complements kernel namespacing with a high-level API which \
 operates at the process level. It runs unix processes with strong \
 guarantees of isolation and repeatability across servers. \
 . \
 Docker is a great building block for automating distributed systems: \
 large-scale web deployments, database clusters, continuous deployment \
 systems, private PaaS, service-oriented architectures, etc. \
 . \
 This package contains the daemon and client, which are \
 officially supported on x86_64 and arm hosts. \
 Other architectures are considered experimental. \
 . \
 Also, note that kernel version 3.10 or above is required for proper \
 operation of the daemon process, and that any lower versions may have \
 subtle and/or glaring issues. \
 "

#
# https://github.com/docker/docker-ce-packaging.git
#  common.mk:
#    DOCKER_CLI_REPO    ?= https://github.com/docker/cli.git
#    DOCKER_ENGINE_REPO ?= https://github.com/docker/docker.git
#    REF                ?= HEAD
#    DOCKER_CLI_REF     ?= $(REF)
#    DOCKER_ENGINE_REF  ?= $(REF)
#
# These follow the tags for our releases in the listed repositories
# so we get that tag, and make it our SRCREVS:
#

SRCREV_docker = "3056208812eb5e792fa99736c9167d1e10f4ab49"
SRCREV_libnetwork = "0dde5c895075df6e3630e76f750a447cf63f4789"
SRCREV_cli = "baeda1f82a10204ec5708d5fbba130ad76cfee49"
SRCREV_FORMAT = "docker_libnetwork"
SRC_URI = "\
	git://github.com/docker/docker.git;branch=20.10;name=docker;protocol=https \
	git://github.com/docker/libnetwork.git;branch=master;name=libnetwork;destsuffix=git/libnetwork;protocol=https \
	git://github.com/docker/cli;branch=20.10;name=cli;destsuffix=git/cli;protocol=https \
	file://0001-libnetwork-use-GO-instead-of-go.patch \
	file://0001-dynbinary-use-go-cross-compiler.patch \
	file://0001-cli-use-external-GO111MODULE-and-cross-compiler.patch \
	file://dockerd-daemon-use-default-system-config-when-none-i.patch \
	file://cli-config-support-default-system-config.patch \
	file://increase_containerd_timeouts.patch \
	file://0001-registry-increase-TLS-and-connection-timeouts.patch \
	file://0001-overlay2-fsync-layer-metadata-files.patch \
	file://0001-Revert-20.10-vendor-update-archive-tar-for-go-1.18.patch \
	"

require recipes-containers/docker/docker.inc
require docker-lmp.inc

# Apache-2.0 for docker
LICENSE = "Apache-2.0"
LIC_FILES_CHKSUM = "file://src/import/LICENSE;md5=4859e97a9c7780e77972d989f0823f28"

DOCKER_VERSION = "20.10.21-ce"
PV = "${DOCKER_VERSION}+git${SRCREV_docker}"

CVE_PRODUCT = "docker"
