# Copyright 1999-2018 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=5

DB_VER="5.3"

inherit autotools db-use eutils fdo-mime flag-o-matic gnome2-utils

MyPV="${PV/_/-}"
MyPN="dogecoin"
MyP="${MyPN}-${MyPV}"

DESCRIPTION="P2P Internet currency favored by Shiba Inus worldwide."
HOMEPAGE="https://dogecoin.com/"
SRC_URI="https://github.com/${MyPN}/${MyPN}/archive/v${MyPV}.tar.gz -> ${MyP}.tar.gz"

LICENSE="MIT ISC GPL-3 LGPL-2.1 public-domain || ( CC-BY-SA-3.0 LGPL-2.1 )"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="dbus ipv6 kde +qrcode upnp"

RDEPEND="
	dev-libs/boost[threads(+)]
	dev-libs/openssl:0[-bindist]
	dev-libs/protobuf:=
	dbus? ( dev-qt/qtdbus:5 )
	dev-qt/qtgui:5
	dev-qt/qtnetwork:5
	dev-qt/qtwidgets:5
	qrcode? (
		media-gfx/qrencode
	)
	upnp? (
		net-libs/miniupnpc
	)
	sys-libs/db:$(db_ver_to_slot "${DB_VER}")[cxx]
	virtual/bitcoin-leveldb
"
DEPEND="${RDEPEND}
	dev-qt/linguist-tools:5
"

DOCS="doc/README.md doc/release-notes.md"

S="${WORKDIR}/${MyP}"

src_prepare() {
	sed -i 's/fPIE/fPIC/g' configure.ac || die
	epatch "${FILESDIR}/${MyPN}-1.8.3-sys_leveldb.patch"
	epatch "${FILESDIR}/${MyP}-bdb53.patch"
	eautoreconf
	rm -r src/leveldb || die
}

src_configure() {
	local my_econf=
	if use upnp; then
		my_econf="${my_econf} --with-miniupnpc --enable-upnp-default"
	else
		my_econf="${my_econf} --without-miniupnpc --disable-upnp-default"
	fi

	append-cppflags -I"$(db_includedir ${DV_VER})"

	econf \
		--enable-wallet \
		--disable-ccache \
		--disable-static \
		--disable-tests \
		--with-system-leveldb \
		--with-system-libsecp256k1  \
		--without-libs \
		--without-utils \
		--without-daemon  \
		--with-gui=qt5 \
		$(use_with dbus qtdbus)  \
		$(use_with qrcode qrencode)  \
		${my_econf}
}

#Tests are broken with and without our litecoin-sys_leveldb.patch
#src_test() {
#	cd src || die
#	emake -f makefile.unix "${OPTS[@]}" test_litecoin
#	./test_litecoin || die 'Tests failed'
#}

src_install() {
	dobin "src/qt/${PN}"

	insinto /usr/share/pixmaps
	newins "share/pixmaps/bitcoin.ico" "${PN}.ico"

	make_desktop_entry "${PN} %u" "Dogecoin-Qt" "/usr/share/pixmaps/${PN}.ico" "Qt;Network;P2P;Office;Finance;" "MimeType=x-scheme-handler/dogecoin;\nTerminal=false"

#	newman contrib/debian/manpages/bitcoin-qt.1 ${PN}.1

#	if use kde; then
#		insinto /usr/share/kde4/services
#		newins contrib/debian/bitcoin-qt.protocol ${PN}.protocol
#	fi
}

update_caches() {
	gnome2_icon_cache_update
	fdo-mime_desktop_database_update
}

pkg_postinst() {
	update_caches
}

pkg_postrm() {
	update_caches
}
