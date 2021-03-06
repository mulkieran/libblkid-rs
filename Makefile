RUST_2018_IDIOMS = -D bare-trait-objects \
                   -D ellipsis-inclusive-range-patterns \
                   -D unused-extern-crates

DENY = -D warnings -D future-incompatible -D unused ${RUST_2018_IDIOMS}

build:
	RUSTFLAGS="${DENY}" cargo build

build-deprecated:
	RUSTFLAGS="${DENY}" cargo build --features=deprecated

clippy:
	cargo clippy --all-targets --all-features -- -D warnings -D clippy::needless_borrow

docs-rust:
	cargo doc --no-deps --package libblkid-rs --package libblkid-rs-sys

docs-travis: docs-rust

fmt:
	cargo fmt

fmt-travis:
	cargo fmt -- --check

release:
	RUSTFLAGS="${DENY}" cargo build --release

test:
	RUSTFLAGS="${DENY}" RUST_BACKTRACE=1 cargo test

.PHONY:
	build
	clippy
	docs-rust
	docs-travis
	fmt
	fmt-travis
	release
	test
