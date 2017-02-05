# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/qrosspython/qrosspython-9999.ebuild,v 1.1 2011/08/22 17:51:37 maksbotan Exp $

EAPI=5

PYTHON_COMPAT=( python3_{3,4} )

EGIT_REPO_URI="https://github.com/biolab/orange3.git"
EGIT_PROJECT="orange3-${PV}"
#EGIT_COMMIT=

inherit distutils-r1 git-2

DESCRIPTION="Data visualization and analysis; data mining through visual programming or Python scripting"
HOMEPAGE="http://www.ailab.si/orange/"
LICENSE=""
SLOT="0"

RDEPEND="
    >=dev-python/numpy-1.9.0
    >=sci-libs/scipy-0.11.0
    >=sci-mathematics/bottlechest-0.7.0
    >=dev-python/chardet-2.3.0
    >=sci-libs/scikits_learn-0.16
    >=dev-python/nose-1.3.4
    >=dev-python/mock-1.0.1
    >=dev-python/jinja-2.6
    dev-python/sphinx
    dev-python/numpydoc
    >=dev-python/openpyxl-2.1.2
    virtual/python-imaging
    dev-python/PyQt4
    >=dev-python/pyqwt-5.1
    dev-python/pyqtgraph
    dev-python/qt-graph-helpers
    dev-python/psycopg:2"
DEPEND="${RDEPEND}"


python_install_all() {
        distutils-r1_python_install_all
}
