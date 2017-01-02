# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

EGO_PN="github.com/decred/dcrd/dcrjson"

if [[ ${PV} = *9999* ]]; then
	inherit golang-vcs
else
	die
fi
inherit golang-build

DESCRIPTION="Concrete types for marshalling to and from the decred JSON-RPC API"
HOMEPAGE="https://github.com/decred/dcrd/tree/master/dcrjson"
LICENSE="ISC"
SLOT="0"
IUSE=""
RESTRICT="test"
DEPEND="dev-go/dcrd-blockchain"
RDEPEND=""
