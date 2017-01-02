# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

EGO_PN="cloud.google.com/go"

if [[ ${PV} = *9999* ]]; then
	inherit golang-vcs
else
	die
fi
inherit golang-build

DESCRIPTION="Provides decred-specific convenience functions and types "
HOMEPAGE="https://google.golang.org/grpc"
LICENSE="ISC"
SLOT="0"
IUSE=""
RESTRICT="test"
DEPEND=""
RDEPEND=""
