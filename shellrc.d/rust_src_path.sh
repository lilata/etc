#! /bin/sh
hash "rustc" >/dev/null 2>&1 && export RUST_SRC_PATH=$(rustc --print sysroot 2>/dev/null)/lib/rustlib/src/rust/src
