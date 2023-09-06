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
