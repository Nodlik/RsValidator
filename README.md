RsValidator
===========

### Install 

```bash
$ bower install rsvalidator
```

### Getting Started

Create new RsValidator object, and after loading of a form or field make *init()*
```js
var v = new RsValidator();
v.init();
```

Example validate input with number from 10 to 29:
```html
<input type="text" name="myRangeNumber" placeholder="Input number from 10 to 29"
    data-_rule="range(10, 29), notBlank"
    data-_type="int"
    data-_error='range("Value should be from 10 to 29"), type("Value type not int"), notBlank("Please, input int from 10 to 29")'
/>

<div data-_place="myRangeNumber"></div>
```

Error message will be added on DOM element with a data attribute *_place*="{ inputName }"

### Available rules

```
* notBlank
* email
* range(min, max)
* equal(value)
* notEqual(value)
```
### Localization

You can localize error message. For example:
```html
<input type="text" name="test"
    data-_rule="notBlank"
    data-_error='notBlank("en": "Value cant be empty", "fr": "La signification ne peut pas être vide")'
/>
```
```js
var v = new RsValidator();
v.init();

v.setLocale('en');
```

Method *setLocale* can be called at any time

### Type conversion

For any widget you can set value type:
```html
<input type="text" name="emailsList"
    data-_rule="email"
    data-_type="array(string)"
/>

<input type="text" name="age"
    data-_type="int"
/>
```

Available types

```
* string
* array(type)
* int
* double
* bool
```

Information in README file not full, please, look at examples!

