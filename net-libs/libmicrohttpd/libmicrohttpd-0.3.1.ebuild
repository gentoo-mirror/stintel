# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $
# Nonofficial ebuild by Ycarus. For new version look here : http://gentoo.zugaina.org/

inherit eutils libtool

DESCRIPTION="libmicrohttpd is a small C library that is supposed to make it easy to run an HTTP server as part of another application."
HOMEPAGE="http://gnunet.org/libmicrohttpd/"
SRC_URI="ftp://ftp.gnu.org/gnu/${PN}/${P}.tar.gz"
RESTRICT="nomirror"

IUSE=""
KEYWORDS="~amd64 ~ppc ~sparc x86"
LICENSE="GPL-2"
SLOT="0"

DEPEND="net-misc/curl"

src_compile() {
        econf || die "econf failed"
        emake -j1 || die "emake failed"
}

src_install() {
        make install DESTDIR=${D} || die "make install failed"
}

