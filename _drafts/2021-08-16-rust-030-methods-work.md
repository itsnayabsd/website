---
date: 2021-08-16 21:42:38 +5:30
title: Methods work
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

## How the hell the following works in the background?

What each method in the following line returns? Whether the return type has any associated functions?

```
 io::stdin()
        .read_line(&mut guess)
        .expect("Failed to read line");
```

What stdin() returns? If that return type has `readline` method associated with it? And whether the return value of `read_line` has any `expect` method associated with it?
