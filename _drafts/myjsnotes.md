---
layout: post
title: Modern javaScript notes from a C developer
category: web
comments: true
google_adsense: true
excerpt:
keywords:
image: /assets/img/deploy_node_app_droplet_codeship.png
toc : true
---
## Introduction
I have been a C developer since early 2016. I wanted to learn a new language recently and I decided to learn JavaScript. The similarities and differences between these two languages often confuses me. So I made the notes for myself primarily. Hope this page can help you too a bit if you are a C developer.
## Comments
## Variables and Keywords
let, var are keywords
if variable is not declared, it is not an error. Variable will be declared as global by the program.
variable names can have js : $,_,atoz, AtoZ
## Data types
js : string, number
undefined and null :
```js
let multipleArg = (a, b, c) => {
        console.log('a : ' + a);
        console.log('b : ' + b);
        console.log('c : ' + c);
}

multipleArg(1); // a = 1, b and c are undefined
/* Passing only the second argument */
multipleArg(undefined, 2); // a and c are undefined. b = 2
```
Above b & c are undefined. But in C we can't call like this.

### Default values of arguments
We can't do this in C
```js
let multipleArg1 = (a, b, c) => {
        console.log('a : ' + a);
        console.log('b : ' + b);
        console.log('c : ' + c);
}

let multipleArg2 = (a = 10, b = 20, c = 30) => {
        console.log('a : ' + a);
        console.log('b : ' + b);
        console.log('c : ' + c);
}
multipleArg1(1); // b and c are undefined
multipleArg2(40); // b = 20, c = 30 and a = 40 even though initialized with 10
```
## Operators
&&(same as C), || (same as C)
### Boolean
### Comparison
## Conditionals
if (same as C),
## Variable scope
let scope is same as C. Variable defined in a block can't access outside of block. Called Lexical scope (static scope). Two types: global scope and local scope
## Function scope
## Statements
Semicolon is optional.
## String operations
string concatenation, string copy or assign
## Printing to the console
## Functions
Function definition:
```js
let funcName = (param) => {
        console.log('The param : ' + param);
}

/* Returns variable with local/block scope. In C we can't return local
 * variables unless it is pointer */
let square= (num) => {
        let square = num * num;
        return square;
}

funcName("string");
funcName(2);
funcName(); // Calling without any arguments. We can't call like this in C.

let result = square(10); // Point
console.log(result);
```
### Callback functions
## Debugging
