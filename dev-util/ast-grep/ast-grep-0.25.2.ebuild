# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

CRATES="
	addr2line@0.21.0
	adler@1.0.2
	aho-corasick@1.1.3
	anes@0.1.6
	ansi_term@0.12.1
	anstream@0.6.14
	anstyle@1.0.7
	anstyle-parse@0.2.4
	anstyle-query@1.0.3
	anstyle-wincon@3.0.3
	anyhow@1.0.86
	assert_cmd@2.0.14
	async-trait@0.1.80
	atty@0.2.14
	auto_impl@1.2.0
	autocfg@1.3.0
	backtrace@0.3.71
	bit-set@0.6.0
	bit-vec@0.7.0
	bitflags@1.3.2
	bitflags@2.5.0
	bstr@1.9.1
	bumpalo@3.15.0
	byteorder@1.5.0
	bytes@1.6.0
	cast@0.3.0
	cc@1.0.104
	cfg-if@1.0.0
	ciborium@0.2.2
	ciborium-io@0.2.2
	ciborium-ll@0.2.2
	clap@4.5.9
	clap_builder@4.5.9
	clap_complete@4.5.8
	clap_derive@4.5.8
	clap_lex@0.7.0
	codespan-reporting@0.11.1
	colorchoice@1.0.1
	convert_case@0.6.0
	criterion@0.5.1
	criterion-plot@0.5.0
	crossbeam-deque@0.8.5
	crossbeam-epoch@0.9.18
	crossbeam-utils@0.8.19
	crossterm@0.25.0
	crossterm@0.27.0
	crossterm_winapi@0.9.1
	crunchy@0.2.2
	ctor@0.2.8
	dashmap@5.5.3
	difflib@0.4.0
	doc-comment@0.3.3
	dyn-clone@1.0.17
	either@1.11.0
	equivalent@1.0.1
	errno@0.3.8
	fastrand@2.1.0
	float-cmp@0.9.0
	form_urlencoded@1.2.1
	futures@0.3.30
	futures-channel@0.3.30
	futures-core@0.3.30
	futures-io@0.3.30
	futures-macro@0.3.30
	futures-sink@0.3.30
	futures-task@0.3.30
	futures-util@0.3.30
	fuzzy-matcher@0.3.7
	fxhash@0.2.1
	gimli@0.28.1
	globset@0.4.14
	half@2.4.1
	hashbrown@0.14.5
	heck@0.4.1
	heck@0.5.0
	hermit-abi@0.1.19
	hermit-abi@0.3.9
	httparse@1.8.0
	idna@0.5.0
	ignore@0.4.22
	indexmap@2.2.6
	indoc@2.0.5
	inquire@0.7.5
	is-terminal@0.4.12
	is_terminal_polyfill@1.70.0
	itertools@0.10.5
	itoa@1.0.11
	js-sys@0.3.69
	libc@0.2.154
	libloading@0.8.4
	linux-raw-sys@0.4.13
	lock_api@0.4.12
	log@0.4.21
	lsp-types@0.94.1
	memchr@2.7.2
	memoffset@0.9.1
	miniz_oxide@0.7.2
	mio@0.8.11
	napi@2.16.8
	napi-build@2.1.3
	napi-derive@2.16.8
	napi-derive-backend@1.0.70
	napi-sys@2.4.0
	newline-converter@0.3.0
	normalize-line-endings@0.3.0
	num-traits@0.2.19
	num_cpus@1.16.0
	object@0.32.2
	once_cell@1.19.0
	oorandom@11.1.3
	parking_lot@0.12.2
	parking_lot_core@0.9.10
	percent-encoding@2.3.1
	pin-project@1.1.5
	pin-project-internal@1.1.5
	pin-project-lite@0.2.14
	pin-utils@0.1.0
	plotters@0.3.5
	plotters-backend@0.3.5
	plotters-svg@0.3.5
	portable-atomic@1.6.0
	predicates@3.1.0
	predicates-core@1.0.6
	predicates-tree@1.0.9
	proc-macro2@1.0.82
	pyo3@0.21.2
	pyo3-build-config@0.21.2
	pyo3-ffi@0.21.2
	pyo3-macros@0.21.2
	pyo3-macros-backend@0.21.2
	pythonize@0.21.1
	quote@1.0.36
	rayon@1.10.0
	rayon-core@1.12.1
	redox_syscall@0.5.1
	regex@1.10.5
	regex-automata@0.4.6
	regex-syntax@0.8.3
	rustc-demangle@0.1.24
	rustix@0.38.34
	ryu@1.0.18
	same-file@1.0.6
	schemars@0.8.21
	schemars_derive@0.8.21
	scopeguard@1.2.0
	semver@1.0.23
	serde@1.0.204
	serde_derive@1.0.204
	serde_derive_internals@0.29.0
	serde_json@1.0.120
	serde_repr@0.1.19
	serde_yaml@0.9.34+deprecated
	signal-hook@0.3.17
	signal-hook-mio@0.2.3
	signal-hook-registry@1.4.2
	similar@2.5.0
	slab@0.4.9
	smallvec@1.13.2
	strsim@0.11.1
	syn@2.0.61
	target-lexicon@0.12.14
	tempfile@3.10.1
	termcolor@1.4.1
	termtree@0.4.1
	thiserror@1.0.62
	thiserror-impl@1.0.62
	thread_local@1.1.8
	tinytemplate@1.2.1
	tinyvec@1.6.0
	tinyvec_macros@0.1.1
	tokio@1.38.0
	tokio-util@0.7.11
	toml_datetime@0.6.6
	toml_edit@0.22.15
	tower@0.4.13
	tower-layer@0.3.2
	tower-lsp@0.20.0
	tower-lsp-macros@0.9.0
	tower-service@0.3.2
	tracing@0.1.40
	tracing-attributes@0.1.27
	tracing-core@0.1.32
	tree-sitter@0.21.0
	tree-sitter-bash@0.21.0
	tree-sitter-c@0.21.4
	tree-sitter-c-sharp@0.21.3
	tree-sitter-cpp@0.22.2
	tree-sitter-css@0.21.0
	tree-sitter-dart@0.0.4
	tree-sitter-elixir@0.2.0
	tree-sitter-facade-sg@0.21.5
	tree-sitter-go@0.21.0
	tree-sitter-haskell@0.21.0
	tree-sitter-html@0.20.3
	tree-sitter-java@0.21.0
	tree-sitter-javascript@0.21.4
	tree-sitter-javascript-sg@0.21.2
	tree-sitter-json@0.21.0
	tree-sitter-kotlin@0.3.6
	tree-sitter-lua@0.1.0
	tree-sitter-php@0.22.7
	tree-sitter-python@0.21.0
	tree-sitter-ruby@0.21.0
	tree-sitter-rust@0.21.2
	tree-sitter-scala@0.21.0
	tree-sitter-swift@0.4.2
	tree-sitter-typescript@0.21.2
	unicode-bidi@0.3.15
	unicode-ident@1.0.12
	unicode-normalization@0.1.23
	unicode-segmentation@1.11.0
	unicode-width@0.1.12
	unindent@0.2.3
	unsafe-libyaml@0.2.11
	url@2.5.0
	utf8parse@0.2.1
	wait-timeout@0.2.0
	walkdir@2.5.0
	wasi@0.11.0+wasi-snapshot-preview1
	wasm-bindgen@0.2.92
	wasm-bindgen-backend@0.2.92
	wasm-bindgen-futures@0.4.42
	wasm-bindgen-macro@0.2.92
	wasm-bindgen-macro-support@0.2.92
	wasm-bindgen-shared@0.2.92
	web-sys@0.3.69
	web-tree-sitter-sg@0.21.3
	winapi@0.3.9
	winapi-i686-pc-windows-gnu@0.4.0
	winapi-util@0.1.8
	winapi-x86_64-pc-windows-gnu@0.4.0
	windows-sys@0.48.0
	windows-sys@0.52.0
	windows-targets@0.48.5
	windows-targets@0.52.5
	windows_aarch64_gnullvm@0.48.5
	windows_aarch64_gnullvm@0.52.5
	windows_aarch64_msvc@0.48.5
	windows_aarch64_msvc@0.52.5
	windows_i686_gnu@0.48.5
	windows_i686_gnu@0.52.5
	windows_i686_gnullvm@0.52.5
	windows_i686_msvc@0.48.5
	windows_i686_msvc@0.52.5
	windows_x86_64_gnu@0.48.5
	windows_x86_64_gnu@0.52.5
	windows_x86_64_gnullvm@0.48.5
	windows_x86_64_gnullvm@0.52.5
	windows_x86_64_msvc@0.48.5
	windows_x86_64_msvc@0.52.5
	winnow@0.6.8
"

inherit cargo

DESCRIPTION="A CLI tool for code structural search, lint and rewriting"
HOMEPAGE="https://ast-grep.github.io/"
SRC_URI="${CARGO_CRATE_URIS}
	https://github.com/ast-grep/ast-grep/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz "

LICENSE="Apache-2.0 Apache-2.0-with-LLVM-exceptions ISC MIT Unicode-DFS-2016"
SLOT="0"
KEYWORDS="~amd64"

# rust does not use *FLAGS from make.conf, silence portage warning
# update with proper path to binaries this crate installs, omit leading /
QA_FLAGS_IGNORED="usr/bin/${PN}"

src_configure() {
	cargo_src_configure --bin ast-grep
}

src_install() {
	cargo_src_install --path crates/cli
}