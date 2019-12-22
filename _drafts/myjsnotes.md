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
let, var, const are keywords
`const` keyword is used instead of `let` for function definitions, formulas, objects whose definitions are not going to be changed. Is this same in case of C also?
if variable is not declared, it is not an error. Variable will be declared as global by the program.
variable names can have js : $,_,atoz, AtoZ
## Data types
js : string, number
undefined and null :
js : strings ' (single quotes) or "  (double quotes)
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
### String methods
```js
let mystring = 'Nayab Basha Sayed';

let length = mystring.length;

console.log(length);
console.log(mystring.toUpperCase());
```
For more string methods: https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/String

## Arrays
Defining an array
```js
const myArr = [];
```
Array can have different data types. Can be a string, boolean, number etc.
Array length can be changed by inserting or deleting members.
```js
const myArr = ['string', 20, true];

console.log(`Array : ${myArr}\nArray length : ${myArr.length}`);

myArr.push(50);

console.log(`Array : ${myArr}\nArray length : ${myArr.length}`);
```
## Built-In objects
### Number
https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Number
### Math
https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Math
### Date
https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Date
### Array
https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Array
Usefule array methods :

push // Add element at the end
pop // Remove element at the end
shift // Delete element at the start
unshift // Add element at the start
splice // Add or remove elements at particular index

For looping, searching       we have in-built methods.
indexOf, splice, findIndex, find

array.find expects boolean `true` while looping through objects. Suppose if we return true in the second loop, the `find` method returns second object.

## Printing to the console
Variables can be accessed wiht ${var} inside console.log. In C, we need to use specifiers.
console.log(`Double the variable ${2 * var}`); // Those are not single quotes. Back tick.
## Objects
Two objects can never be same even though they look exactly the same unless both are reference to same object.
```js
let oneObject = {};
let twoObject = {};

console.log(oneObject === twoObject); //false
console.log(oneObject == twoObject); // false

let threeObject = oneObject;

console.log(threeObject == oneObject); //true
```
### Methods
function definitions in an object.
```js
let restaurant = {
        name : 'ABC',
        guestCapacity : 75,
        guestCount : 0,
        seatParty(count) {
                this.guestCount += count;
        },
        removeParty(count) {
                this.guestCount -= count;
        },
        checkAvailability(count) {
                let seatsLeft = this.guestCapacity - this.guestCount;
                return count <= seatsLeft;
        }
}

console.log(restaurant.checkAvailability(10));
```
### Creating object
```js
let obj = {};
```
In C we need structure definition first to create a structure variable.
### Structures inside structures / Objects inside objects / Array of objects
### Accessing object properties / structure members

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
### Passing arguments to functions
Passing arguments to functions is always by reference. The same equivalent in C is passing arguments by it's address.
## Debugging
