---
date: 2021-08-24 13:26:54 +5:30
title: Rust Variables and Mutability with Examples
layout : rust-post
category : rust
comments : true
google_adsense: true
excerpt : Learn about Rust variables, mutability of variables, constants, shadowing in Rust with examples.
keywords : Rust variables, Rust mutability, constants, Rust shadowing, Rust examples, Rust shadowing vs mut
image : /assets/img/rust/rust-variables-mutability.png
toc : true
---
## Introduction
A variable is a name given to a memory location to access the data in that memory location. We can create variables using certain keywords in Rust.
```rust
fn main() {
    let a = 2;
    println!("The value of a is {}", a);
}
```
In the above example, we used the keyword *let* to create a variable. The keyword *let* binds the value *2* to the variable *a*.

*println!* is a macro the prints the formatted text to the console. You can learn more about printing macros [here](/programming/rust-formatterd-print.html).

Run the program using the command `cargo run` in the console/terminal and see the output is printing to the console.

{% include image.html url="/rust/rust-variables-mutability.png" description="Rust Variables, Mutability and Shadowing" %}
## Mutablility of Variables

By default the variables in the Rust are immutable. i.e. unable to be changed. Run the following program and see if you are facing any errors.
```rust
fn main() {
    let a = 2;
    println!("The value of a is {}", a);
    a = 3;
    println!("The value of a is {}", a);
}
```
You might see the following errors on your screen.
```rust
error[E0384]: cannot assign twice to immutable variable
```
To make the variable mutable we use the keyword *mut*.
```rust
fn main() {
    let mut a = 2;
    println!("The value of a is {}", a);
    a = 3;
    println!("The value of a is {}", a);
}
```
The output -
```
The value of a is 2
The value of a is 3
```
Here is another example.
```rust
fn main() {
    let mut a = 2;
    print_square(&a);
    a = 20;
    println!("The value of a is {} now.", a);
}

fn print_square(a:&i32) {
    println!("Square of {} is {}", *a, *a * *a);
}
```
In the above example, we are not expecting the function *print_square* to change the value of *a*. So the reference to the *a* is passed as an argument to the function as immutable. You get an error while compiling if you assign any value to *a* inside this function. This mechanism is to prevent unnecessary bugs arising if somehow the function tries to change it's value.
## Constants
Constants in Rust are always immutable. You can't change the value once it is assigned as a constant. The keyword we use here is *const*. You can't use *mut* keyword along with *const*. The data type must be specified during constant declaration. More about data types in the next post.
```rust
fn main() {
    const PI:f64 = 3.14;
    let radius:f64 = 2.0;

    println!("Area of circle is {} m.sq.", PI * radius * radius);
}
```
## Shadowing
In Rust, variable with the same name can be declared multiple times. Often to change the data type of the variable or to do some operations on immutable data type. In both cases, the recent variable declaration shadows the earlier declarations.
```rust
fn main() {
    let _a = "nayab.xyz";
    let _a = 32;
    println!("The value of a is {}", _a);
}
```
In the above example, the first *_a* declaration is of *string* data type. The next declaration *let _a = 32;* changes *_a* data type form *string* to *i32*.

Here is one more example ..
```rust
fn main() {
    let _var = 10;
    println!("The value of variable -> {}", _var);
    let _var = 100;
    println!("The value of immutable shadowed variable -> {}", _var);
    let _var = _var * 100;
    println!("The value of immutable shadowed variable -> {}", _var);
}
```
As we already know, we can't change the value of immutable variable. But with the help of shadowing, that is, using *let* keyword we can perform some operations while re-declaring the variable and thus change the value of it.

The output -
```
The value of variable -> 10
The value of immutable shadowed variable -> 100
The value of immutable shadowed variable -> 10000
```