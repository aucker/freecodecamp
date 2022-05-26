## JavaScript:milky_way:
Something I learned by freeCodeCamp:baby:
### `var`, `let` and `const`

There are three way to declare a variable, `var`, `let`, and `const`. 
The `var` can be altered at anytime.
ES6 brings `let`, it is like the `let mut` in `Rust`, you can alter it. 
the `const` in `JavaScript` is somewhat like in `Rust`. The string is **immutable** when declared with `const`,
however, the entries of array are *mutable* and can be changed freely, even if the array was declared with `const`. 
```javascript
const ourArray = [50, 40, 30];
ourArray[0] = 15;
```

### Strict Equality

Strict equality (`===`) is the counterpart to the equality operator (`==`). However, unlike the equality operator, which attempts to convert both values being compared to a common type, the strict equality operator does not perform a type conversion.

If the values being compared have different types, they are considered unequal, and the strict equality operator will return false.
**e.g.**
```javascript
3 === 3 // true
3 === '3' // false
3 == '3' //true
3 == "3" //true
```
`3 == '3'` returns true because JavaScript performs type conversion from string to number. `3 === '3'` returns false because the types are different and type conversion is not performed.
**Note:**
In JavaScript, you can determine the type of a variable or a value with the `typeof` operator, as follows:
```javascript
typeof 3 //number
typeof '3' //string
typeof "3" // string
```

Remember that `undefined` is a keyword, not a string.

### Accessing Object Properties with dot`.` or Bracket Notation`[]`
If the property of the object you are trying to access has a space in its name, you will need to use bracket notation.

However, you can still use bracket notation on object properties without spaces.

Here is a sample of using bracket notation to read an object's property:
```javascript
const myObj = {
  "Space Name": "Kirk",
  "More Space": "Spock",
  "NoSpace": "USS Enterprise"
};

myObj["Space Name"];
myObj['More Space'];
myObj["NoSpace"];
```
Note that property names with spaces in them must be in quotes (single or double).

### Accessing Object Properties with Variables
Another use of bracket notation on objects is to access a property which is stored as the value of a variable. This can be very useful for iterating through an object's properties or when accessing a lookup table.

Here is an example of using a variable to access a property:
```javascript
const dogs = {
  Fido: "Mutt",
  Hunter: "Doberman",
  Snoopie: "Beagle"
};

const myDog = "Hunter";
const myBreed = dogs[myDog];
console.log(myBreed);
```
The string Doberman would be displayed in the console.

Another way you can use this concept is when the property's name is collected dynamically during the program execution, as follows:
```javascript
const someObj = {
  propName: "John"
};

function propPrefix(str) {
  const s = "prop";
  return s + str;
}

const someProp = propPrefix("Name");
console.log(someObj[someProp]);
```
`someProp` would have a value of the string `propName`, and the string `John` would be displayed in the console.

Note that we do not use quotes around the variable name when using it to access the property because we are using the *value* of the variable, not the *name*.

### Delete Properties from a JavaScript Object
We can also delete properties from objects like this:
```javascript
delete ourDog.bark;
```

### Using Objects for Lookups
Objects can be thought of as a key/value storage, like a dictionary. If you have tabular data, you can use an object to lookup values rather than a `switch` statement or an `if/else` chain. This is most useful when you know that your input data is limited to a certain range. For example:
```javascript
function phoneticLookup(val) {
  let result = "";

  // Only change code below this line
  switch(val) {
    case "alpha":
      result = "Adams";
      break;
    case "bravo":
      result = "Boston";
      break;
    case "charlie":
      result = "Chicago";
      break;
    case "delta":
      result = "Denver";
      break;
    case "echo":
      result = "Easy";
      break;
    case "foxtrot":
      result = "Frank";
  }

  // Only change code above this line
  return result;
}

phoneticLookup("charlie");
```
which is same as the following:
```javascript
function phoneticLookup(val) {
  let result = "";

  const lookup = {
    "alpha": "Adams",
    "bravo": "Boston",
    "charlie": "Chicago",
    "delta": "Denver",
    "echo": "Easy",
    "foxtrot": "Frank"
  };
  result = lookup[val];
  // Only change code above this line
  return result;
}

phoneticLookup("charlie");
```
### Manipulating Complex Objects
Sometimes you may want to store data in a flexible Data Structure. A JavaScript object is one way to handle flexible data. They allow for arbitrary combinations of `strings`, `numbers`, `booleans`, `arrays`, `functions`, and `objects`.

Here's an example of a complex data structure:
```javascript
const ourMusic = [
  {
    "artist": "Daft Punk",
    "title": "Homework",
    "release_year": 1997,
    "formats": [ 
      "CD", 
      "Cassette", 
      "LP"
    ],
    "gold": true
  }
];
```
This is an array which contains one object inside. The object has various pieces of metadata about an album. It also has a nested `formats` array. If you want to add more album records, you can do this by adding records to the top level array. Objects hold data in a property, which has a key-value format. In the example above, `"artist": "Daft Punk"` is a property that has a key of `artist` and a value of `Daft Punk`. [JavaScript Object Notation](http://www.json.org/) or `JSON` is a related data interchange format used to store data.
```JSON
{
  "artist": "Daft Punk",
  "title": "Homework",
  "release_year": 1997,
  "formats": [ 
    "CD",
    "Cassette",
    "LP"
  ],
  "gold": true
}
```
**Note:** You will need to place a comma after every object in the array, unless it is the last object in the array.


### Accessing Nested Objects
The sub-properties of objects can be accessed by chaining together the dot or bracket notation.

Here is a nested object:
```javascript
const ourStorage = {
  "desk": {
    "drawer": "stapler"
  },
  "cabinet": {
    "top drawer": { 
      "folder1": "a file",
      "folder2": "secrets"
    },
    "bottom drawer": "soda"
  }
};

ourStorage.cabinet["top drawer"].folder2;
ourStorage.desk.drawer;
```
`ourStorage.cabinet["top drawer"].folder2` would be the string `secrets`, and `ourStorage.desk.drawer` would be the string `stapler`.

### Accessing Nested Arrays
As we have seen in earlier examples, objects can contain both nested objects and nested arrays. Similar to accessing nested objects, array bracket notation can be chained to access nested arrays. Example:
```javascript
const ourPets = [
  {
    animalType: "cat",
    names: [
      "Meowzer",
      "Fluffy",
      "Kit-Cat"
    ]
  },
  {
    animalType: "dog",
    names: [
      "Spot",
      "Bowser",
      "Frankie"
    ]
  }
];

ourPets[0].names[1];
ourPets[1].names[0];
```

