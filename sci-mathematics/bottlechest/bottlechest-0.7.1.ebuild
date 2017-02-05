# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/qrosspython/qrosspython-9999.ebuild,v 1.1 2011/08/22 17:51:37 maksbotan Exp $

EAPI=5

PYTHON_COMPAT=( python3_{2,3,4} )

inherit distutils-r1

DESCRIPTION="Fast NumPy array functions written in Cython"
HOMEPAGE="https://github.com/biolab/bottlechest"
SRC_URI="https://github.com/biolab/bottlechest/archive/${PV}.tar.gz"
SLOT="0"

RDEPEND="dev-python/numpy"
DEPEND="${RDEPEND}"

python_install_all() {
        distutils-r1_python_install_all
}
