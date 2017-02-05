# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-libs/pjsip/pjsip-1.8.10.ebuild,v 1.1 2011/02/22 10:59:09 elvanor Exp $

EAPI="2"

#SRC_URI="http://www.pjsip.org/release/${PV}/pjproject-${PV}.tar.bz2"
ESVN_REPO_URI="http://svn.pjsip.org/repos/pjproject/trunk"
ESVN_PROJECT="pjsip"

#inherit eutils flag-o-matic
inherit eutils flag-o-matic subversion

DESCRIPTION="Multimedia communication libraries written in C language
for building VoIP applications."
HOMEPAGE="http://ww\w.pjsip.org/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"

#PACKAGE USE:
    #epoll - (DEFAULT DISABLE) Use /dev/epoll ioqueue on Linux (experimental)
    #shared - (DEFAULT DISABLE) Build shared libraries
    #alsa - use alsa sound
    #oss - use oss sound
    #video - use video feature
    #ext-sound - (DEFAULT DISABLE) PJMEDIA will not provide any sound device backend
    #g711 - use g711 sound codec
    #l16 - use l16 sound codec
    #gsm - use gsm sound codec
    #g722 - use g722 sound codec
    #g7221 - use g 7221 sound codec
    #speex - use SPEEX sound codec
    #ilbc - use ilbc sound codec
    #libsamplerate - (DEFAULT DISABLE) Link with libsamplerate when available
    #ffmpeg - use ffmpeg codecs
    #v4l2 - use  Video4Linux2
    #h264 - use h264 video codec
    #libyuv - use libyuv video codec
    #ssl - Exclude SSL support
    #apps - build console utilites
    #srv - install server scripts
    #qt4 - Qt4 support
    #doc - build DOCs
    #examples - build Examples
    #nat - buils nats Server and Client
    #python - build Python API

IUSE="
    epoll
    shared
    alsa
    video
    v4l2
    ext-sound
    gsm
    speex
    ilbc
    libsamplerate
    sdl
    ffmpeg
    libyuv
    ssl
    apps
    srv
    qt4
    doc
    examples
    nat
    python
    "

DEPEND="alsa? ( media-libs/alsa-lib )
    gsm? ( media-sound/gsm )
    ilbc? ( dev-libs/ilbc-rfc3951 )
    speex? ( media-libs/speex )
    ssl? ( dev-libs/openssl )
    sdl? ( media-libs/libsdl2 )
    ffmpeg? ( media-video/ffmpeg )
    libyuv? ( media-libs/libyuv )
    v4l2? ( media-libs/libv4l )
    srv? ( net-misc/telnet-bsd )"

RDEPEND="${DEPEND}"

#S="${WORKDIR}/pjproject-${PV}"
S="${WORKDIR}/trunk"

src_prepare() {

    #depends from video

    if use video; then
        echo '' >> ${S}/pjlib/include/pj/config_site.h
        echo '// Enable Video function.' >> ${S}/pjlib/include/pj/config_site.h
        echo '#define PJMEDIA_HAS_VIDEO    1' >> ${S}/pjlib/include/pj/config_site.h

        if use ffmpeg; then
            echo '' >> ${S}/pjlib/include/pj/config_site.h
            echo '// FFMPEG provide h263/h263+/h264 codec' >> ${S}/pjlib/include/pj/config_site.h
            echo '#define PJMEDIA_HAS_FFMPEG    1' >> ${S}/pjlib/include/pj/config_site.h
        fi

        if use sdl; then
            echo '' >> ${S}/pjlib/include/pj/config_site.h
            echo '// Renderer dev depends on SDL.' >> ${S}/pjlib/include/pj/config_site.h
            echo '#define PJMEDIA_VIDEO_DEV_HAS_SDL   1' >> ${S}/pjlib/include/pj/config_site.h
        fi

        if use qt4; then
            echo qt4
            echo '' >> ${S}/pjlib/include/pj/config_site.h
            echo '// Qt4 GUI suport.' >> ${S}/pjlib/include/pj/config_site.h
            echo '#define PJMEDIA_VIDEO_DEV_HAS_QT   1' >> ${S}/pjlib/include/pj/config_site.h
        fi

        #if use ffmpeg; then
            #echo '' >> ${S}/pjlib/include/pj/config_site.h
            #echo '// FFMPEG provide h263/h263+/h264 codec' >> ${S}/pjlib/include/pj/config_site.h
            #echo '#define PJMEDIA_VIDEO_DEV_HAS_FFMPEG    1' >> ${S}/pjlib/include/pj/config_site.h
        #fi

        if use v4l2; then
            echo '' >> ${S}/pjlib/include/pj/config_site.h
            echo '//Video4Linux2 support' >> ${S}/pjlib/include/pj/config_site.h
            echo '#define PJMEDIA_VIDEO_DEV_HAS_V4L2    1' >> ${S}/pjlib/include/pj/config_site.h
        fi
    fi

    # Remove target name from lib names
    #sed -i -e 's/-$(TARGET_NAME)//g' \
        #-e 's/= $(TARGET_NAME).a/= .a/g' \
        #-e 's/-$(LIB_SUFFIX)/$(LIB_SUFFIX)/g' \
        #$(find . -name '*.mak*' -o -name Makefile) || die "sed failed."

    # Fix hardcoded prefix and flags
    #sed -i \
        #-e 's/poll@/poll@\nexport PREFIX := @prefix@\n/g' \
        #-e 's!prefix = /usr/local!prefix = $(PREFIX)!' \
        #Makefile \
        #build.mak.in || die "sed failed."


    # apply -fPIC globally
    cp ${FILESDIR}/user.mak ${S}
}

src_configure() {

    #econf  $(use_enable epoll) \
           #$(use_enable shared) \
           #$(use_enable ext-sound) \
           #$(use_enable libsamplerate) || die "econf failed."

    ${S}/configure --prefix=/usr \
                   --mandir=/usr/share/man \
                   --infodir=/usr/share/info \
                   --datadir=/usr/share \
                   --sysconfdir=/etc \
                   --localstatedir=/var/lib \
                   --libdir=/usr/lib64

}

src_compile() {
    append-flags -fPIC
    emake dep || die "emake dep failed."
    emake -j1 || die "emake failed."
}

src_install() {
    #arch value
    local arch=`uname -m`

    # catch some rare exceptions
    case "${arch}" in
	ppc)
	    # still ppc on 32bit pre-2.6.16 machines
	    arch="powerpc"
	    ;;
    esac

    DESTDIR="${D}" emake install || die "emake install failed."

    if use python; then
	pushd pjsip-apps/src/python
	python2 setup.py install --prefix="${D}/usr/"
	popd
    fi

    if use doc; then
	dodoc README.txt README-RTEMS
    fi

    if use examples; then
	insinto "/usr/share/doc/${P}/examples"
	doins "${S}/pjsip-apps/src/samples/"*
    fi

    if use apps; then
        ls ${S}/pjsip-apps/bin
        newbin "${S}/pjsip-apps/bin/pjsua-${arch}-unknown-linux-gnu" "pjsua"
        newbin "${S}/pjsip-apps/bin/pjsystest-${arch}-unknown-linux-gnu" "pjsystest"
        for x in `ls ${S}/pjsip-apps/bin/samples/${arch}-unknown-linux-gnu`; do
            newbin "${S}/pjsip-apps/bin/samples/${arch}-unknown-linux-gnu/${x}" "pjsip_${x}"
        done
    fi
    
    if use nat; then
        ls ${S}/pjnath/bin
        newbin "${S}/pjnath/bin/pjnath-test-${arch}-unknown-linux-gnu" "pjnath-test"
        newbin "${S}/pjnath/bin/pjturn-client-${arch}-unknown-linux-gnu" "pjturn-client"
        newbin "${S}/pjnath/bin/pjturn-srv-${arch}-unknown-linux-gnu" "pjturn-srv"
    fi
    
    if ( use srv )&&( use apps ); then
        newconfd "${FILESDIR}/pjsua.confd" "pjsua"
        dodir "/etc/pjsua"
        insinto "/etc/pjsua"
        newins "${FILESDIR}/pjsua.cfg" "pjsua.cfg"
        newins "${FILESDIR}/pjsua.com" "pjsua.com"
        newinitd "${FILESDIR}/pjsua.initd" "pjsua"
        newbin "${FILESDIR}/pjterm" "pjterm"
    fi
}
