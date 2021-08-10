---
date: 2021-08-16 21:42:44 +5:30
title: Enum
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


{% include image.html url="rust_extension_pack.png" description="Setting up Rust in VS Code for Linux" %}

The following is possible. It's called shadowing of earlier variable with new type.
```
fn main() {
    let val:String = "Hello".to_string();
    println!("{}", val);
    let val:i32 = 10;
    println!("{}", val);
}
```
