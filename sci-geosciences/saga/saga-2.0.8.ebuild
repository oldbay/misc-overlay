# Copyright 2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $


EAPI=4

inherit eutils

DESCRIPTION="SAGA System for Automated Geoscientific Analysis"
HOMEPAGE="http://www.saga-gis.org"
SRC_URI="http://downloads.sourceforge.net/saga-gis/saga_${PV}.tar.gz"

LICENSE="GPL-2 LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~x86"

IUSE="unicode python"
DEPEND=">=x11-libs/wxGTK-2.8.0
		<=sci-libs/proj-4.7.0
		sci-libs/gdal"
RDEPEND=${DEPEND}

src_prepare() {
    epatch "${FILESDIR}"/${P}-ldconfig.patch
}

src_configure() {
	econf \
		$(use_enable unicode) \
		$(use_enable python) \
		|| die
}

src_install() {
	emake DESTDIR=${D} install || die
}
