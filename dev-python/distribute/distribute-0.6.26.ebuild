EAPI=5
PYTHON_COMPAT=(python2_7)

inherit distutils-r1

DESCRIPTION="distribute legacy wrapper"
HOMEPAGE="http://packages.python.org/distribute"
SRC_URI="http://pypi.python.org/packages/source/d/${PN}/${P}.tar.gz"

LICENSE="PSF ZPL"
SLOT="0"
KEYWORDS="~amd64 ~x86"

DEPEND=">=dev-python/setuptools-0.7[${PYTHON_USEDEP}]"
RDEPEND="${DEPEND}"
