---
title: "Python Day 01: Setup and Syntax"
status: draft
---

## Topic Overview
- Core syntax for professional Python: variables, numeric types, booleans, truthiness, indentation, expressions, operators, lists, tuples, sets, dicts.
- Goal: know how Python executes and how data behaves so you can write correct, fast loops and data transforms for real work and LeetCode.
- Think of today as wiring your mental circuit board: you will learn what Python treats as “solid ground” (truthy) or “empty space” (falsy), how numbers behave when divided, and why a list can betray you if you copy it the wrong way.

## Essential Concepts

### How Python executes
- Python runs from top to bottom and trusts your indentation. When you indent, you are telling the interpreter, “this belongs together.” The moment you unindent, the block is over. That makes code visually honest: if two lines share the same indent, they execute at the same structural level.
- Indentation is syntax. Use 4 spaces; tabs will break mixed code. Blocks are defined by indentation, not braces.
```python
if x > 0:
    print("positive")
    x -= 1
print("done")  # outside the block
```
- Top to bottom execution. Names are created at first assignment. Be wary of using a name before binding.

### Names bind to objects
- A variable name is just a sticky note on an object. Moving the note does not move the object; it just points somewhere else. Two names can point to the same list. It is great for sharing, but dangerous when you expected a copy.
- Python binds names to objects; the type lives with the object, not the name.
```python
a = 3          # a -> int(3)
a = "three"    # a now points to a str
x = y = []     # both point to the same list (shared!)
```
- Swapping and unpacking are first-class.
```python
first, second = 10, 20
first, second = second, first
head, *rest = [1, 2, 3, 4]  # head=1, rest=[2,3,4]
```

### Numeric types: int, float, bool
- Integers never overflow; floats give you speed with the usual floating-point warts. Booleans are tiny integers wearing a truth-value badge.
- `int` is arbitrary precision; `float` is double precision; `bool` is a subtype of `int` (`True == 1`).
```python
2 ** 100            # works, no overflow
5 / 2               # 2.5 (float division)
5 // 2              # 2   (floor division)
-5 // 2             # -3  (floors toward -inf)
5 % 2               # 1   (modulus)
1 == True, 2 == True  # (True, False)
```
- Use `math.isclose` for float comparison; never rely on exact equality for non-integers.
```python
import math
print(0.1 + 0.2 == 0.3)             # Output: False
print(math.isclose(0.1 + 0.2, 0.3)) # Output: True
```

### Truthiness
- Python loves to shortcut. It quietly treats many values as false so you can write “if items” instead of “if len(items) > 0”. Know the falsy set and your conditionals read like English.
- Falsy values: `False, None, 0, 0.0, 0j, '', [], (), {}, set(), range(0)`.
```python
if items:           # true when list is non-empty
    ...
if value is None:   # distinct from empty containers
    ...
```
- Logical operators are short-circuiting and return operands, not coerced booleans.
```python
result = cache or compute()   # compute() only runs if cache is falsy
safe = user and user.get("id")  # returns id or falsy value
```

### Expressions and operators
- Python tries to keep expressions readable: compare chains like math, and remember that `is` is about identity, not equality. Augmented assignment often mutates instead of re-binding, which can be a performance win.
- Comparison chaining: `a < b < c` checks both relations.
```python
5 < x < 10    # Pythonic range check
```
- Identity vs equality: `is` compares object identity; `==` compares value.
```python
x is None     # correct None check
x == None     # avoid, works but is noisy
```
- Augmented assignment mutates in place when possible.
```python
nums = [1, 2]
nums += [3]   # same list grows; like extend
```

### Lists (mutable sequences)
- Lists are your workhorse for LeetCode: they resize fast at the end, slice cleanly, and support O(1) append/pop from the tail. Just remember that slicing creates copies, while index assignment mutates in place.
- Ordered, indexable, sliceable, grow/shrink in place.
```python
arr = [1, 2, 3]
arr.append(4)
arr.extend([5, 6])
arr[0] = 99
arr_slice = arr[1:3]      # copy of that slice
arr_copy = arr[:]         # shallow copy of whole list
```
- Pitfall: `arr_copy = arr` aliases; changes affect both.

### Tuples (immutable sequences)
- Tuples are lists with the safety on. They are great for lightweight records, dict keys, and returning multiple values without fear of accidental mutation.
- Lightweight fixed collections, often for records or dictionary keys.
```python
pt = (10, 20)
x, y = pt      # unpack
```
- Immutability makes them hashable when contents are hashable.

### Sets (unique, unordered)
- Use a set when you only care about membership and uniqueness. If you can phrase a problem as “has this been seen?” or “what are the common elements?”, a set is often the right hammer.
- Great for membership tests and de-duplication.
```python
seen = {1, 2, 3}
seen.add(3)          # no effect
seen.update([3, 4])  # {1,2,3,4}
{1, 2} | {2, 3}      # union -> {1,2,3}
{1, 2} & {2, 3}      # intersection -> {2}
```
- Pitfall: cannot contain unhashable types (e.g., lists, dicts).

### Dictionaries (key-value mapping)
- Dicts power nearly every fast solution: counting, grouping, memoization, adjacency lists. They remember insertion order, which makes iteration predictable.
- Preserve insertion order (Python 3.7+). Common for lookups and counting.
```python
counts = {"a": 1, "b": 2}
counts["c"] = counts.get("c", 0) + 1
for key, val in counts.items():
    ...
```
- Safe access patterns:
```python
value = counts.get("missing")      # returns None if absent
value = counts.get("missing", 0)   # default fallback
```

### Mutability and copying (core mental model)
- Mutability is where many subtle bugs hide. If two names share a mutable object, one change affects both views. Copy when you need independence; share when you need coordination.
- Mutating a list/set/dict changes the object for all names pointing to it.
```python
a = [1, 2]
b = a
b.append(3)
# both a and b now see [1, 2, 3]
```
- Create shallow copies when you need independence: `list(a)`, `a[:]`, `set(s)`, `dict(m)`.

### Minimal I/O for fast tests
- For quick practice and LeetCode-style inputs, keep I/O lean: strip whitespace, cast to `int`, and print results with clear spacing.
- Quick scripts often need only `print` and `input`.
```python
n = int(input().strip())
print(n * 2)
```

### Common pitfalls today
- Mixing tabs/spaces breaks indentation.
- Confusing `/` with `//` and getting float vs int behavior.
- Using `is` for value comparison (wrong for numbers/strings; use `==`).
- Forgetting short-circuit behavior and triggering `NoneType` errors (e.g., `user and user["id"]` is safer than `user["id"]`).

## Advanced or related topics to explore later
- `decimal.Decimal` and `fractions.Fraction` for precise arithmetic.
- Copy semantics: `copy.copy` vs `copy.deepcopy` (preview for Day 7).
- Structural pattern matching (`match/case`) for dispatch.
- Typed dictionaries and `typing` basics for larger codebases.

## References
- Python tutorial (data structures, control flow): https://docs.python.org/3/tutorial/
- Built-in functions: https://docs.python.org/3/library/functions.html
- Data model: https://docs.python.org/3/reference/datamodel.html
- Style guide (PEP 8): https://peps.python.org/pep-0008/

## Practice exercises (no solutions)
1. Read an integer `n` and print `n`, `n*2`, `n//2`, and `n/2` on one line.
2. Given `a` and `b`, swap them without a temporary variable and print the result.
3. Given a list of integers, return a new list with each element squared; do not mutate the input.
4. Given a list with duplicates, produce a list of unique values preserving the original order.
5. Count how many times each value appears in a list using only dictionaries (no `collections` yet).
6. Given two sets of integers, print their intersection and union.
7. Build a dictionary that maps strings to their lengths for an input list of words.
8. Check if all values in a list are truthy; then check if any value is truthy (practice `all`/`any`).
9. Given a nested list like `[[1, 2], [3, 4]]`, make a shallow copy and mutate only the copy; show the effect on the original.
10. Write a small REPL that keeps reading numbers until blank input, storing them in a list, then prints the min, max, and average (use both `/` and `//`).
