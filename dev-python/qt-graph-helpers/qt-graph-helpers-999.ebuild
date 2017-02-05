# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/qrosspython/qrosspython-9999.ebuild,v 1.1 2011/08/22 17:51:37 maksbotan Exp $

EAPI=5

PYTHON_COMPAT=( python3_{3,4} )

EGIT_REPO_URI="https://github.com/biolab/qt-graph-helpers.git"
EGIT_PROJECT="qt-graph-helpers-${PV}"
#EGIT_COMMIT=

inherit distutils-r1 git-2

DESCRIPTION="Qt Graph Helpers are a group of PyQt helpers."
HOMEPAGE="http://www.ailab.si/orange/"
LICENSE=""
SLOT="0"

RDEPEND="
    dev-python/PyQt4
    >=dev-python/pyqwt-5.1
    dev-python/pyqtgraph"
DEPEND="${RDEPEND}"


python_install_all() {
        distutils-r1_python_install_all
}
