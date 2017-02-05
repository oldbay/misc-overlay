# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

inherit eutils rpm

MY_P="Sikuli-X-1.0rc3 (r905)-linux-x86_64"

SRC_URI="
		https://launchpad.net/sikuli/sikuli-api/x1.0-rc3/+download/Sikuli-X-1.0rc3%20%28r905%29-linux-x86_64.zip
		ftp://ftp.muug.mb.ca/mirror/fedora/linux/updates/14/x86_64/opencv-2.1.0-6.fc14.x86_64.rpm
		"

DESCRIPTION="Sikuli is a visual technology to automate and test graphical user
			interfaces (GUI) using images (screenshots)."
HOMEPAGE="www.sikuli.org"


LICENSE=""
SLOT="0"
KEYWORDS="~amd64"

IUSE=""

DEPEND="
	app-arch/rpm
	media-libs/tiff:3
	sci-libs/lapack-reference
	media-libs/libdc1394
	>=virtual/jdk-1.6.0
	x11-misc/wmctrl
	app-arch/unzip
"
RDEPEND="${DEPEND}"


INSTALLDIR="/opt/${PN}"

S="${WORKDIR}/${MY_P}"


src_install() {
	dodir "${INSTALLDIR}"

	#copy sikuli-ide files to image directory
	mv "${S}"/Sikuli-IDE/libs "${D}/${INSTALLDIR}/" || die "Cannot install core-files"
	mv "${S}"/Sikuli-IDE/*.jar "${D}/${INSTALLDIR}/" || die "Cannot install *.jar files"
	mv "${S}"/Sikuli-IDE/*.sh "${D}/${INSTALLDIR}/" || die "Cannot install *.sh files"

	#patch sikuli-ide.sh script
	sed -i '2s/`.*$/\/opt\/sikuli/' "${D}/${INSTALLDIR}"/sikuli-ide.sh || die 'sed failed'

	#create environment
	#echo -n "LD_LIBRARY_PATH=\"${INSTALLDIR}/libs: \${LD_LIBRARY_PATH}\"" > "${T}/90${PN}"
	echo -n "LD_LIBRARY_PATH=\"${INSTALLDIR}/libs\"" > "${T}/90${PN}"
	doenvd "${T}/90${PN}" || die "Create environment flle failed"

	#have to install opencv2.1 files into libs directory because sikuli doesn't work with opencv2.3
	mv "${WORKDIR}"/usr/lib64/* "${D}/${INSTALLDIR}"/libs

	dosym /usr/lib64/lapack/reference/liblapack.so "${INSTALLDIR}"/libs/liblapack.so.3
	dosym /usr/lib64/libtiff.so "${INSTALLDIR}"/libs/libtiff.so.4
	dosym "${INSTALLDIR}"/sikuli-ide.sh /usr/bin/sikuli-ide

	newmenu "${FILESDIR}"/${PN}.desktop ${PN}.desktop
}
