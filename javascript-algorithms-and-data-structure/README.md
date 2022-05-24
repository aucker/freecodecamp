## JavaScript:milky_way:
Something I learned by freeCodeCamp:baby:
* `var`, `let` and `const`

There are three way to declare a variable, `var`, `let`, and `const`. 
The `var` can be altered at anytime.
ES6 brings `let`, it is like the `let mut` in `Rust`, you can alter it. 
the `const` in `JavaScript` is somewhat like in `Rust`. The string is **immutable** when declared with `const`,
however, the entries of array are *mutable* and can be changed freely, even if the array was declared with `const`. 
```javascript
const ourArray = [50, 40, 30];
ourArray[0] = 15;
```

* Strict Equality

Strict equality (`===`) is the counterpart to the equality operator (`==`). However, unlike the equality operator, which attempts to convert both values being compared to a common type, the strict equality operator does not perform a type conversion.

If the values being compared have different types, they are considered unequal, and the strict equality operator will return false.

**e.g.**
```javascript
3 === 3 // true
3 === '3' // false
3 == '3' //true
```
`3 == '3'` returns true because JavaScript performs type conversion from string to number. `3 === '3'` returns false because the types are different and type conversion is not performed.
**Note:**
In JavaScript, you can determine the type of a variable or a value with the `typeof` operator, as follows:
```javascript
typeof 3 //number
typeof '3' //string
```