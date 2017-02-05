# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-libs/pjsip/pjsip-1.8.10.ebuild,v 1.1 2011/02/22 10:59:09 elvanor Exp $

EAPI="2"

inherit eutils flag-o-matic

DESCRIPTION="Multimedia communication libraries written in C language
for building VoIP applications."
HOMEPAGE="http://ww\w.pjsip.org/"
SRC_URI="http://www.pjsip.org/release/${PV}/pjproject-${PV}.tar.bz2"

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
    #doc - build DOCs
    #examples - build Examples
    #nat - buils nats Server and Client
    #python - build Python API

IUSE="
    epoll
    shared
    alsa
    oss
    video
    ext-sound
    g711
    l16
    gsm
    g722
    g7221
    speex
    ilbc
    libsamplerate
    sdl
    ffmpeg
    v4l2
    h264
    libyuv
    ssl
    apps
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
    h264? ( media-libs/openh264 )
    libyuv? ( media-libs/libyuv )"

RDEPEND="${DEPEND}"

S="${WORKDIR}/pjproject-${PV}"

src_prepare() {
    # Remove target name from lib names
    sed -i -e 's/-$(TARGET_NAME)//g' \
	-e 's/= $(TARGET_NAME).a/= .a/g' \
	-e 's/-$(LIB_SUFFIX)/$(LIB_SUFFIX)/g' \
	$(find . -name '*.mak*' -o -name Makefile) || die "sed failed."

    # Fix hardcoded prefix and flags
    sed -i \
	-e 's/poll@/poll@\nexport PREFIX := @prefix@\n/g' \
	-e 's!prefix = /usr/local!prefix = $(PREFIX)!' \
	Makefile \
	build.mak.in || die "sed failed."

    # apply -fPIC globally
    cp ${FILESDIR}/user.mak ${S}

    # TODO: remove deps to shipped codecs and libs, use system ones
    # rm -r third_party
    # libresample: https://ccrma.stanford.edu/~jos/resample/Free_Resampling_Software.html
}

src_configure() {

    econf  $(use_enable epoll) \
           $(use_enable shared) \
           $(use_enable alsa sound) \
           $(use_enable oss) \
           $(use_enable video) \
           $(use_enable ext-sound) \
           $(use_enable g711 g711-codec) \
           $(use_enable l16 l16-codec) \
           $(use_enable gsm gsm-codec) \
           $(use_enable g722 g722-codec) \
           $(use_enable g7221 g7221-codec) \
           $(use_enable speex speex-codec) \
           $(use_enable ilbc ilbc-codec) \
           $(use_enable libsamplerate) \
           $(use_enable ffmpeg) \
           $(use_enable sdl) \
           $(use_enable v4l2) \
           $(use_enable h264 openh264) \
           $(use_enable libyuv) \
           $(use_enable ssl) || die "econf failed."

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
        newbin "${S}/pjsip-apps/bin/pjsua" "pjsua"
        newbin "${S}/pjsip-apps/bin/pjsystest" "pjsystest"
        for x in `ls ${S}/pjsip-apps/bin/samples/${arch}-pc-linux-gnu`; do
            newbin "${S}/pjsip-apps/bin/samples/${arch}-pc-linux-gnu/${x}" "pjsip_${x}"
        done
    fi
    
    if use nat; then
        newbin "${S}/pjnath/bin/pjnath-test" "pjnath-test"
        newbin "${S}/pjnath/bin/pjturn-client" "pjturn-client"
        newbin "${S}/pjnath/bin/pjturn-srv" "pjturn-srv"
    fi

}