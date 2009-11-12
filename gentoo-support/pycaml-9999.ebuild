# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header$

inherit findlib python eutils git

IUSE=""

DESCRIPTION="Bindings for Python and OCaml"
HOMEPAGE="http://github.com/chemoelectric/pycaml"
SRC_URI=""
EGIT_REPO_URI="git://github.com/chemoelectric/pycaml.git"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ppc x86"

RDEPEND="dev-ml/ocaml-make-6.29.3"

DEPEND=">=dev-lang/ocaml-3.11.1
        >=dev-lang/python-2.6.4
        ${RDEPEND}"

S="${WORKDIR}/${PN}"


pkg_setup() {
	if ! built_with_use --missing true dev-lang/ocaml ocamlopt; then
		eerror "${PN} needs to be built with native code support from ocaml"
		eerror "You first need to have a native code ocaml compiler."
		eerror "You need to install dev-lang/ocaml with ocamlopt useflag on."
		die "Please install ocaml with ocamlopt useflag"
	fi
}

src_compile() {
	cd "${S}"
	python_version
	emake -j1 PYVER="${PYVER}" get_libdir="$(get_libdir)" || die "emake failed"
}

src_install() {
	# Use findlib to install properly, especially to avoid
	# the shared library mess
	findlib_src_preinst

	cd "${S}"
	ocamlfind install pycaml \
		dllpycaml_stubs.so* libpycaml_stubs.a pycaml.a  pycaml.cma \
        pycaml.cmi pycaml.cmo pycaml.cmx pycaml.cmxa pycaml.ml pycaml.mli \
		pycaml.o  pycaml_stubs.c pycaml_stubs.h  pycaml_stubs.o META
}
