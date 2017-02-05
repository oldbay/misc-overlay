# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/qrosspython/qrosspython-9999.ebuild,v 1.1 2011/08/22 17:51:37 maksbotan Exp $

EAPI=5

PYTHON_COMPAT=( python2_7 )

EGIT_REPO_URI="https://github.com/biolab/orange.git"
EGIT_PROJECT="orange-${PV}"
#EGIT_COMMIT=

inherit distutils-r1 git-2

DESCRIPTION="Data visualization and analysis; data mining through visual programming or Python scripting"
HOMEPAGE="http://www.ailab.si/orange/"
LICENSE=""
SLOT="0"

RDEPEND="
    dev-python/numpy
    dev-python/matplotlib
    virtual/python-imaging
    >=dev-python/pyqwt-5.1"
DEPEND="${RDEPEND}"


python_install_all() {
        distutils-r1_python_install_all
}
