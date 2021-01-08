# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{7..9} )

inherit distutils-r1

DESCRIPTION="Python library to interact with keepass databases (supports KDBX3 and KDBX4) "
HOMEPAGE="https://github.com/libkeepass/pykeepass"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND="
	>=dev-python/argon2-cffi-19.1.0[${PYTHON_USEDEP}]
	>=dev-python/construct-2.9.4[${PYTHON_USEDEP}]
	>=dev-python/future-0.17.0[${PYTHON_USEDEP}]
	>=dev-python/lxml-4.3.4[${PYTHON_USEDEP}]
	>=dev-python/pycryptodome-3.8.2[${PYTHON_USEDEP}]
	>=dev-python/python-dateutil-2.8.0[${PYTHON_USEDEP}]
"
DEPEND="${RDEPEND}"

PATCHES=( "${FILESDIR}/0001-setup.py-exclude-tests-directory.patch" )

src_prepare() {
	distutils-r1_src_prepare
	# pycryptodomex to pycryptodome conversion
	sed -i 's/Cryptodome/Crypto/g' pykeepass/kdbx_parsing/{common,twofish}.py || die
}

python_test() {
	"${EPYTHON}" tests/tests.py -v || die
}
