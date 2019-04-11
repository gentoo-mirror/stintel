# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=5

DESCRIPTION="Vanity address generator"
HOMEPAGE="https://github.com/samr7/vanitygen"

case "${PV}" in
	9999)
		inherit git-r3
		EGIT_REPO_URI="git://github.com/samr7/vanitygen.git"
		;;
	*)
		eend "No releases."
		;;
esac

LICENSE="AGPL-3"
SLOT="0"
KEYWORDS="~amd64"
IUSE="opencl"

DEPEND=""
RDEPEND="${DEPEND}"

src_compile() {
	emake
	use opencl && make oclvanitygen
}

src_install() {
	exeinto /usr/bin
	doexe "${S}/vanitygen"
	use opencl && doexe "${S}/oclvanitygen"
}
