# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/qrosspython/qrosspython-9999.ebuild,v 1.1 2011/08/22 17:51:37 maksbotan Exp $

EAPI=5

PYTHON_COMPAT=( python{2_7,3_4} )

EGIT_REPO_URI="git://github.com/piranha/opster.git"
EGIT_PROJECT="opster-${PV}"
#EGIT_COMMIT=

PYTHON_DEPEND="2"

inherit distutils git-2

DESCRIPTION="Opster is a command line parser, intended to make writing command line applications easy and painless."
HOMEPAGE="http://opster.readthedocs.org/en/latest/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""
IUSE="debug"

DEPEND=""
RDEPEND=""

python_install_all() {
        distutils_python_install_all

}
