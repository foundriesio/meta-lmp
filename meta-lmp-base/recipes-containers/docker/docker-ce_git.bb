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

SRCREV_docker = "659604f9ee60f147020bdd444b26e4b5c636dc28"
SRCREV_cli = "cb74dfcd853482dd43cb553106b1e0cd237acb3e"
SRCREV_FORMAT = "docker_cli"
SRC_URI = "\
	git://github.com/docker/docker.git;branch=24.0;name=docker;protocol=https \
	git://github.com/docker/cli;branch=24.0;name=cli;destsuffix=git/cli;protocol=https \
	file://0001-dynbinary-use-go-cross-compiler.patch;patchdir=src/import \
	file://0001-cli-use-external-GO111MODULE-and-cross-compiler.patch \
	"

DOCKER_COMMIT = "${SRCREV_docker}"

require docker.inc

# Apache-2.0 for docker
LICENSE = "Apache-2.0"
LIC_FILES_CHKSUM = "file://src/import/LICENSE;md5=4859e97a9c7780e77972d989f0823f28"

DOCKER_VERSION = "24.0.2-ce"
PV = "${DOCKER_VERSION}+git${SRCREV_docker}"

CVE_PRODUCT = "docker mobyproject:moby"
