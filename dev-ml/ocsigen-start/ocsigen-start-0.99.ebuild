# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

inherit findlib eutils

DESCRIPTION="Eliom Base Application with users, (pre)registration, notifications, etc."
HOMEPAGE="https://github.com/ocsigen/ocsigen-start"

LICENSE="LGPL-3"
SLOT="0/${PV}"
IUSE=""

if [ "${PV#9999}" != "${PV}" ] ; then
	inherit git-r3
	SRC_URI=""
	EGIT_REPO_URI="https://github.com/ocsigen/ocsigen-start"
	KEYWORDS=""
else
	SRC_URI="https://github.com/ocsigen/ocsigen-start/archive/v${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64"
fi

RDEPEND="dev-lang/ocaml:=
	dev-ml/pgocaml:=
	dev-ml/macaque:=
	dev-ml/ocaml-safepass:=
	dev-ml/eliom:=
	dev-ml/ocsigen-toolkit:=
	dev-ml/ppx_deriving:=
	dev-ml/yojson:=
"
DEPEND="${RDEPEND}"

src_prepare() {
	epatch "${FILESDIR}/magick.patch"
}

src_install() {
	findlib_src_preinst
	DESTDIR="${ED}" OCAMLPATH="${OCAMLFIND_DESTDIR}" emake install
	dodoc README.md
}
