#!/usr/bin/env bash
# Program to set snap's version, used by the `version-script` keyword
# 林博仁(Buo-ren, Lin) <Buo.Ren.Lin@gmail.com> © 2018

set \
	-o errexit \
	-o errtrace \
	-o nounset \
	-o pipefail

init(){
	local \
		upstream_version \
		packaging_revision

	upstream_version="$(
		# FIXME: Hardcoded version string
		strings \
			prime/TdhCad_linux \
			| grep --extended-regexp '^[0-9]+\.[0-9]+\.[0-9]+$' \
			| head --lines=1
	)"

	packaging_revision="$(
		git \
			describe \
			--abbrev=4 \
			--always \
			--match nothing \
			--dirty=-d
	)"

	printf \
		-- \
		'%s' \
		"${upstream_version}+pkg-${packaging_revision}"

	exit 0
}

init "${@}"
