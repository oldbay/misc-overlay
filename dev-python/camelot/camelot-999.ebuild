# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/qrosspython/qrosspython-9999.ebuild,v 1.1 2011/08/22 17:51:37 maksbotan Exp $

EAPI=5

PYTHON_COMPAT=( python2_7 )

EHG_REPO_URI="https://bitbucket.org/conceptive/camelot"
EHG_PROJECT="${PN}"

PYTHON_DEPEND="2"

inherit distutils-r1 mercurial

DESCRIPTION="A python GUI framework on top of Sqlalchemy and Qt, inspired by the Django admin interface."
HOMEPAGE="http://www.python-camelot.com/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""
IUSE="debug"
S="${WORKDIR}/Camelot-${PV}-gpl-pyqt"

DEPEND="dev-python/PyQt4
        >=dev-python/sqlalchemy-0.8.0
        dev-python/sqlalchemy-migrate
        >=dev-python/jinja-2.6
        >=dev-python/chardet-2.1.1
        >=dev-python/xlwt-0.7.4
        >=dev-python/xlrd-0.9.0"
RDEPEND="${DEPEND}"

python_install_all() {
        distutils-r1_python_install_all

}
