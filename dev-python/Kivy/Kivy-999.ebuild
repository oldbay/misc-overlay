# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/Kivy/Kivy-1.8.0.ebuild,v 1.4 2014/08/10 21:06:30 slyfox Exp $

EAPI="5"

PYTHON_COMPAT=( python{2_7,3_1,3_3,3_4} )

EGIT_REPO_URI="git://github.com/kivy/kivy.git"
EGIT_PROJECT="Kivy-${PV}"
#EGIT_COMMIT="021f58905e494339cdb8357e05eb6b1c6dd320ed"

inherit distutils-r1 git-2

DESCRIPTION="A software library for rapid development of hardware-accelerated multitouch applications"
HOMEPAGE="http://kivy.org/"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="cairo camera doc examples garden gstreamer spell"

DEPEND="dev-python/cython
	garden? ( dev-python/kivy-garden )
	gstreamer? ( dev-python/gst-python:0.10 )
	cairo? ( dev-python/pycairo )
	spell? ( dev-python/pyenchant )
	dev-python/pygame
	dev-python/setuptools
	camera? ( media-libs/opencv )
	virtual/python-imaging
	"
RDEPEND="${DEPEND}"

src_prepare() {
	sed -e '/data_files=/d' -i "${S}/setup.py"
}

src_install() {
	distutils-r1_src_install
	use doc && dodoc -r doc/sources/*
	use examples && insinto "/usr/share/doc/${PF}/" && doins -r examples
}
