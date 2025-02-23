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

- No buffer overflows thanks to exact and correct one-time allocation
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
