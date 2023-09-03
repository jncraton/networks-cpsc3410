Python Strings
==============

String
------

- A sequence of characters
- [Textbook chapter](https://www.py4e.com/html3/06-strings)
- [Module documentation](https://docs.python.org/3/library/string.html)

Lists
-----

- A list is a sequence of items
- Many list operations can be applied to strings

Indexing
--------

```python
>>> "abc"[1]
'b'
>>> "abc"[-1]
'c'
```

Modification
------------

- Unlike lists, Python strings are immutable and cannot be changed

```python
>>> "abc"[-1] = 'x'
Traceback (most recent call last):
  File "<stdin>", line 1, in <module>
TypeError: 'str' object does not support item assignment
```

---

Why would strings be immutable?

---

Benefits
--------

- No buffer overflows due to exact and correct one-time allocation
- Simplified and faster language internals (string-based names are guaranteed to never change)
- Memory efficiency (all strings with the same value are the same string)

---

What if we want to modify a string?

Slicing
-------

- Allows a segment of a list or string to be selected
- Similar syntax to individual character access

Slicing Example
---------------

```python
>>> "abcdefg"[2:4]
'cd'
>>> "abcdefg"[2:]
'cdefg'
>>> "abcdefg"[:-2]
'abcde'
>>> "abcdefg"[:]
'abcdefg'
```

Creating a modified string
--------------------------

```python
>>> s = "abcdefg"
>>> new_s = s[:2] + 'x' + s[3:]
>>> new_s
'abcdefg'
```

What about more complex operations?

Split
-----

- Splits a string into a list of strings around a `separator`

```python3
>>> "ab:cd:ef".split(":")
['ab', 'cd', 'ef']
```

Find
----

- Returns the index of a string in another

```python
>>> "abcdef".find("cd")
2
```

Regular Expressions
===================

Regular Expressions
-------------------

- A sequence of characters that describe a pattern in a string
- [Textbook overview](https://www.py4e.com/html3/11-regex)

Importing Modules
-----------------

- Regular expressions are a part of the Python standard library, but the module is not available to the interpreter until it is imported

```python
import re
```

RE Basics
---------

- Characters are generally matched literally.

```python
import re

s = "the quick brown fox jumped over the lazy dog"
re.findall("dog", s)
```

```python
['dog']
```

RE Methods
----------

- [re.findall](https://docs.python.org/3/library/re.html#re.findall) - Return non-overlapping matches as a list
- [re.match](https://docs.python.org/3/library/re.html#re.match) - Returns a `match` object if pattern matches string
- [re.sub](https://docs.python.org/3/library/re.html#re.sub) - Replace pattern with replacement in string
- [Many more](https://docs.python.org/3/library/re.html)

RE Boolean Or
-------------

- Pipes (|) can be used for Boolean or

```python
import re

s = "the quick brown fox jumped over the lazy dog"
re.findall("dog|fox", s)
```

```python
['fox', 'dog']
```

RE Quantifiers
--------------

- `?` - zero or one occurrences of preceding element
- `*` - zero or more occurrences of preceding element
- `+` - one or more occurrences of preceding element
- `{n}` - exactly n occurrences of preceding element

---

```python
import re

s = "the quick brown fox jumped over the lazy dog"
re.findall("ov?", s)
```

```python
['o', 'o', 'ov', 'o']
```

RE Grouping
-----------

- Parens can be used for grouping

```python
import re

s = "the quick brown fox jumped over the lazy dog"
re.findall("(d|f)o(g|x)", s)
```

```python
[('fox', 'f', 'x'), ('dog', 'd', 'g')]
```

RE Bracket Expressions
----------------------

- Brackets `[]` may be used to match a single character against a set of characters

```python
import re

s = "the quick brown fox jumped over the lazy dog"
re.findall("[df]o[gx]", s)
```

```python
['fox', 'dog']
```

RE Character Classes
--------------------

Several special character classes are provided:

- `\w` - alphanumeric characters
- `\d` - digits
- `\s` - whitespace characters
- `.` - anything

---

```python
import re

s = "the quick brown fox jumped over the lazy dog"
re.findall("\s...\s", s)
```

```python
[' fox ', ' the ']
```
