# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=poetry
PYTHON_COMPAT=(python3_{10..12} pypy3)

inherit distutils-r1 pypi

DESCRIPTION="List of known HTML tag names"
HOMEPAGE="https://github.com/djlint/html-tag-names https://pypi.org/project/html-tag-names/"
SRC_URI="https://files.pythonhosted.org/packages/source/${PN::1}/${PN}/${P}.tar.gz"

S=${WORKDIR}/${P}

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"
