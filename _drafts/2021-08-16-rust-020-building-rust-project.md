---
date: 2021-08-16 21:42:38 +5:30
title: Building a Rust Project
layout : rust-post
category : rust
comments : true
google_adsense: true
excerpt : 
keywords : 
image : /assets/img/rust_extension_pack.png
toc : true
---
## Introduction

Let's start by creating a folder in the home directory and do the programs in that directory.

{% include image.html url="rust_extension_pack.png" description="Setting up Rust in VS Code for Linux" %}

Often you want to download the pakages from crates.io. Cargo will download it for you.

How to choose which rust version you want to use to compile?

Cargo by default searches the code in src directory

Cargo created binary in target/debug directory

Cargo.lock keeps track of dependent crates versions

`cargo check` is faster than `cargo build`

`cargo build --release` stores binary executable in `target/release` directory

let, match, methods, associated functions

## Using external crates
Using rand crate

Add the version of rand crate under dependencies in Cargo.toml file [dependencies] section header.

```
[dependencies]
rand = "0.8.3"
```
Whether above crate supports only set of Rust versions or all? Check in the crates.io

The sematic version above guarantees any crate version of rand from 0.8.3 to before 0.9.0 works fine with your existing code.

What is Cargo.lock file is for??

cargo update will update the crate versions to newer but only supported i.e until 0.8.9 but not 0.9.0
