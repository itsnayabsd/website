---
date: 2021-08-18 23:23:53 +5:30
title: Formatted Print in Rust with Examples
layout : post
category : programming
comments : true
google_adsense: true
excerpt : Print statements are very common in programming. Learn how to use print statements in Rust with the bunch of macros available in Rust.
keywords : Rust print!, println!, format!, eprint!, eprintln!, formatted print in Rust, Debug print in Rust, formatted print macros in Rust, Rust format float, Rust format hex, Rust format debug, Rust format decimal.
image : /assets/img/rust/rust-formatted-print.jpg
toc : true
---
## Introduction
Print statements are very common in programming. Either these are used to prompt user for information or to debug the program or to save the program logs for troubleshooting later.

In Rust programming language, printing is handled by bunch of macros listed below. Macros in Rust end with exclamatory mark (`!`).

{% include image.html url="/rust/rust-formatted-print.jpg" description="Formatted Print in Rust" %}

## print!
*print!* is a macro that prints formatted text to the console (or stdout). This macro receives multiple arguments. The first argument is the literal string. The curly braces `{}` in the first argument will be replaced by the their referencing values and then the resulting formatted string is printed to a console.

Here are few examples.
### Example 1
```rust
fn main() {
    print!("Hello World {}!\n", 2); // \n is the new line character.
}
```
In above example, the curly braces will be replaced by *2* and the resulting formatted string is sent to console.

Run the program using the following command.
```bash
cargo run
```
The output -
```
Hello World 2!
```
### Example 2
```rust
fn main() {
    print!("Hello {}, Numbers -> {}, {}, {}\n", "World!", 3, 2, 0.5);
}
```
The output -
```
Hello World!, Numbers -> 3, 2, 0.5
```
The first *{}* is replaced with *World!*, the second {} is replaced with *3*, the third {} is replaced with *2* and so on...
### Example 3
```rust
fn main() {
    print!("Hello {0}, Numbers -> {2}, {3}, {1}\n", "World!", 3, 2, 0.5);
}
```
The output -
```
Hello World!, Numbers -> 2, 0.5, 3
```
In the above example, *{0}* always points to *"World!"*, *{1}* always points to 3, *{2}* always points to 2 and *{3}* points to 0.5

### Example 4
```rust
fn main() {
    print!("The binary equivalent of {} is {:b}\n", 20, 20);
}
```
The output -
```
The binary equivalent of 20 is 10100
```
### Example 5
```rust
fn main() {
    print!("The coordinates -> ({x},{y},{z})\n", z=3, y=2, x=1);
}
```
The output -
```
The coordinates -> (1,2,3)
```
### Example 6
```rust
fn main() {
    print!("This is padding {num} with {digit} spaces -> \
    {num:>digit$}\n\
    And this is padding {num} with {digit} 1s -> {num:1>digit$}\n",
    num = 5, digit = 6);
}
```
The output -
```
This is padding 5 with 6 spaces ->      5
And this is padding 5 with 6 1s -> 111115
```
## println!
The *println!* macro is same as *print!* except that the former adds the new line `\n` automatically at the end of the string.
```rust
fn main() {
    let v = [1, 4, 5, 8];
    println!("{:#?}", v); // Pretty print
}
```
The output -
```
[
    1,
    4,
    5,
    8,
]
```
## format!
```rust
fn main() {
    let new_string= format!("Hello World {:.1}!", 2.0);
    println!("{}", new_string);
}
```
The *format!* macro writes the formal string to a string variable.

The output -
```
Hello World 2.0!
```
## eprint!
The *eprint!* is same as *print!*, except the output is sent to standard error (by default console for both stdout and stderr). *eprint!* is used to report error messages.
## eprintln!
The *eprintln!* macro is same as *eprint!* macro, except it adds the new line at the end of string.
