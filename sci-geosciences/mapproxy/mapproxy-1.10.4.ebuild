
EAPI=5
PYTHON_COMPAT=( python2_7 )

inherit distutils-r1

DESCRIPTION="MapProxy is a tile cache and WMS proxy"
HOMEPAGE="https://mapproxy.org"
SRC_URI="https://github.com/mapproxy/mapproxy/archive/${PV}.tar.gz -> ${P}.tar.gz"
LICENSE="Apache-2.0"

SLOT="0"

KEYWORDS="~amd64 ~arm ~arm64"
#IUSE="gunicorn"

RDEPEND="
    dev-python/pillow[${PYTHON_USEDEP}]
    dev-python/pyyaml[${PYTHON_USEDEP}]
    dev-python/lxml[${PYTHON_USEDEP}]
    =sci-libs/proj-4*
    "
DEPEND=${RDEPEND}
#DEPEND="${RDEPEND}
#    gunicorn? (
#	www-servers/gunicorn
#	dev-python/eventlet[${PYTHON_USEDEP}]
#    )
#"

python_install_all() {
    distutils-r1_python_install_all
    cp ${S}/mapproxy/__init__.py "${D}$(python_get_sitedir)"/mapproxy
}
