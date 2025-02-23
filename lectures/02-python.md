Introduction to Python
======================

Lab 0
-----

- Confirms that you have a Python environment installed
- Requires you to solve a few basic Python programming problems

Python
------

- Multi-paradigm programming language started in the early 90s
- One of the most popular general-purpose languages in use today

Iteration
---------

- Repeating the operation multiple times
- `for`, `while`, and list comprehensions are common tools in Python

Syntax
------

- Python's syntax is different from most other programming languages
- Whitespace (specifically indentation) are part of the language syntax

Counting Example
----------------

JavaScript:

```javascript
for (let i = 0; i < 10; i++) {
    console.log(i)
}
```

Python:

```python
for i in range(10):
    print(i)
```

Invalid Python
--------------

Correct:

```python
for i in range(10):
    print(i)
```

IndentationError:

```python
for i in range(10):
print(i)
```

Expressions
-----------

- Evaluate to values

Examples
--------

```python
4 == 4 # Evaluates to True
-5 < 0 # Evaluates to True
7 + 4 # Evalutes to 11
not True # Evalates to False
```

Logic
-----

- It is frequently helpful for a program to be able to make a decision about what to do next
- `if` is a common tool for this

Example
-------

```python
i = -5
if i > 0:
  print("i is positive")
else:
  print("i is negative")
```

Lists
-----

- A sequence of values
- Items can be of any type
- Items are commonly referred to as elements

Example
-------

```python
primes = [2, 3, 5, 7, 11]

# Print all primes in list
for p in primes:
    print(p)

print(primes[0]) # Print the first prime
```

Functions
---------

- Useful for bundling up code to be used from multiple places
- Functions can be called to perform a task

Example
-------

```python
def is_negative(i):
    if i > 0:
        return False
    else:
        return True

print(is_negative(5))
```
Multi-paradigm
--------------

- Imperative
- Functional
- Object oriented

Imperative Programming
----------------------

We provide instructions that are executed in order

Imperative Example
------------------

```python
items = [1,2,3,4]
result = list()

for i in items:
  square = i * i
  result.append(square)

print(result)
```

Functional Programming
----------------------

Functions are first-class citizens in the language and can be passed and assigned

Functional Example
------------------

```python
def square(n):
  return n*n

squares = map(square, [1,2,3,4])
print(list(squares))
```

Object-Oriented Programming
---------------------------

Data is combined with the functions that operate on it.

OOP Example
-----------

```python
class Items:
  def __init__(self, values):
    self.values = values

  def squares(self):
    return [i*i for i in self.values]

items = Items([1,2,3,4])
print(items.squares())
```
