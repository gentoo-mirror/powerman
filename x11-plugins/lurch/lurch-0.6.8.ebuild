# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
CMAKE_MAKEFILE_GENERATOR=emake  # since top-level Makefile expects a child Makefile

inherit toolchain-funcs cmake-utils

DESCRIPTION="OMEMO encryption for libpurple (XEP-0384)"
HOMEPAGE="https://github.com/gkdr/lurch"
SRC_URI="https://github.com/gkdr/lurch/releases/download/v${PV}/lurch-${PV}-src.tar.gz -> ${P}.tar.gz
https://github.com/gkdr/libomemo/archive/v0.7.0.tar.gz -> ${P}-libomemo-0.7.0.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

# NOTE
# - We cannot unbundle net-libs/libsignal-protocol-c
#   because upstream uses non-API/internal function
#   session_builder_process_pre_key_signal_message
# - The build systems of axc (ex-libaxolotl)
#   at https://github.com/gkdr/axc and libomemo
#   at https://github.com/gkdr/libomemo build static
#   libraries only (*.a) so it is not clear when or
#   how to best unbundle them, either
RDEPEND="
	dev-db/sqlite
	dev-libs/glib
	dev-libs/libgcrypt:=
	dev-libs/libxml2
	dev-libs/mxml
	net-im/pidgin:=
	"
DEPEND="
	${RDEPEND}
	virtual/pkgconfig
	"

CMAKE_USE_DIR="${S}"/lib/axc/lib/libsignal-protocol-c
BUILD_DIR="${CMAKE_USE_DIR}"/build

src_unpack() {
	unpack "${P}.tar.gz"
	cd "${S}/lib" || die
	einfo "Updating libomemo to 0.7.0"
	tar xf "${DISTDIR}/${P}-libomemo-0.7.0.tar.gz" -C libomemo --strip-components 1 || die "Failed to unpack ${P}-libomemo-0.7.0.tar.gz"
}

src_configure() {
	local mycmakeargs=(
		-DBUILD_SHARED_LIBS=OFF  # top-level Makefile expects .a file
		-DCMAKE_C_FLAGS=-fPIC
	)
	cmake-utils_src_configure
}

src_compile() {
	cmake-utils_src_compile

	local makeargs=(
		CC="$(tc-getCC)"
		LIBGCRYPT_CONFIG="$(tc-getPROG LIBGCRYPT_CONFIG libgcrypt-config)"
		PKG_CONFIG="$(tc-getPKG_CONFIG)"
		XML2_CONFIG="$(tc-getPROG XML2_CONFIG xml2-config)"

		CMAKE=/bin/true  # to stop Makefile from calling CMake, once more
	)
	emake "${makeargs[@]}"
}

src_install() {
	default  # use top-level Makefile, not cmake-utils_src_install
}
