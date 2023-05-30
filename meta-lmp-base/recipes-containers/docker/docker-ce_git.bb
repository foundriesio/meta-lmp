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

SRCREV_docker = "9dbdbd4b6d7681bd18c897a6ba0376073c2a72ff"
SRCREV_cli = "ef23cbc4315ae76c744e02d687c09548ede461bd"
SRCREV_FORMAT = "docker_cli"
SRC_URI = "\
	git://github.com/docker/docker.git;branch=23.0;name=docker;protocol=https \
	git://github.com/docker/cli;branch=23.0;name=cli;destsuffix=git/cli;protocol=https \
	file://0001-dynbinary-use-go-cross-compiler.patch;patchdir=src/import \
	file://0001-cli-use-external-GO111MODULE-and-cross-compiler.patch \
	file://dockerd-daemon-use-default-system-config-when-none-i.patch;patchdir=src/import \
	file://cli-config-support-default-system-config.patch;patchdir=cli \
	file://increase_containerd_timeouts.patch \
	file://0001-registry-increase-TLS-and-connection-timeouts.patch;patchdir=src/import \
	file://0001-overlay2-fsync-layer-metadata-files.patch;patchdir=src/import \
	file://0001-Fsync-layer-once-extracted-to-file-system.patch;patchdir=src/import \
	"

DOCKER_COMMIT = "${SRCREV_docker}"

require docker.inc
require docker-lmp.inc

# Apache-2.0 for docker
LICENSE = "Apache-2.0"
LIC_FILES_CHKSUM = "file://src/import/LICENSE;md5=4859e97a9c7780e77972d989f0823f28"

DOCKER_VERSION = "23.0.6-ce"
PV = "${DOCKER_VERSION}+git${SRCREV_docker}"

CVE_PRODUCT = "docker mobyproject:moby"
