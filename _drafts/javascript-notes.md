---
layout: post
category: web
title: My JavaScript Notes
excerpt: Some key point to remember while writing javascript coding.
comments: false
google_adsense: false
---
* The arguments and return value of javascript functions are either functions or data.  
{% include image.html url="js_functions.png" description="javascript function" %} 

* Avoid `block comments` (`/*..*/`)  

* Keywords to remember
{% highlight js %}
abstract
boolean break byte
case catch char class const continue
debugger default delete do double
else enum export extends
false final finally float for function
goto
if implements import in instanceof int interface
long
native new null
package private protected public
return
short static super switch synchronized
this throw throws transient true try typeof
var volatile void
while with
{% endhighlight %}
  {% if jekyll.environment == 'production' and page.google_adsense %}
  {% include goog_inart_2par.html %}
  {% endif %}

* JavaScript has a single number type. Internally, it is represented as 64-bit floating point.

* A string literal can be wrapped in single quotes or double quotes.
JavaScript does not have a character type. To represent a character, make a string with just one character in it.

* The escape sequences allow for inserting characters into strings that are not normally permitted, such as backslashes, quotes, and control characters.  
The \u convention allows for specifying character code points numerically.  
`"A" === "\u0041"`

* If you leave `var` keyword off, you won't get an error. But variable will be created in global scope, not in the scope you defined it in.
{% highlight js %}
someVar = 10;
{% endhighlight %}

* Arrays are ordered list of values, of any type
{% highlight js %}
var myArray = ["Hello", 45, true, "World"];
{% endhighlight %}
To change value at particular index,
{% highlight js %}
myArray[3] = "Hello";
{% endhighlight %}

* Objects are unordered collection of key-value pairs.
{% highlight js %}
var myObj = {key1: "firstkey", "my other key": 4};
{% endhighlight %}
To access object arribute:
{% highlight js %}
myObj.key1; //gives o/p: "firstkey"
myObj["my other key"] // gives o/p: 4
{% endhighlight %}
The following will not work:  
`myObj[key1];` or `myObj."my other key"`  
To add one more key-value pair,
{% highlight js %}
myObj.onemorekey = "ding";
{% endhighlight %}

* Breaking out of all loops when condition matches.
We are using labelled loop for this.
{% highlight js %}
outer:
for (var i = 0; i < 20; i++) {
        for (var j = 0; j < 10; j++) {
                console.log(i, j);
                if (i==0 &&j == 9)
                        break outer;
        }
}
{% endhighlight %}
 * Printing `prototype` and `property` of object:
{% highlight js %}
var obj = {ding:20, ving:40, sing:60}

console.log("\t\tObj");
console.log("\t\t===");
console.log("\tPrototype\tProperty");
console.log("\t=========\t========Property");
for (var x in obj) {
        console.log("\t%s\t\t%d",x,obj[x]);
}
{% endhighlight %}
Above code gives following output:
~~~~
		Obj
		===
	Prototype	Property
	=========	========
	ding		20
	ving		40
	sing		60
~~~~

* Setting default values for variable
{% highlight js %}
var otherName = "";
var name = otherName || "default";
console.log(name);
{% endhighlight %}
Above code gives `default` to `name` if `otherName` is empty.

* In function, the value to be returned must follow `return` keyword on the same line. Otherwise it will return `Undefined` because of automatic semicolon insertion..

* The following function returns object. When the return value is assigned to a variable, we can access object properties using dot notation of variable.
{% highlight js %}
function myFunction(){
    return {dong: 'bell'}
}

var ding = myFunction();
console.log(ding.dong);
{% endhighlight %}
This gives following output.
~~~~
bell
~~~~

* Function definition without name is called `anonymous` function.
{% highlight js %}
function() {
//This is an anonymous function
}
{% endhighlight %}

* Unlike `C` language, javascript doesn't have block scope.
{% highlight js %}
if (true) {
	var ding = 2;
}
console.log(ding);
{% endhighlight %}
This will give following output.
~~~~
2
~~~~
But javascript has function scope.
