---
title: "Going In With Rust: The Interview Prep Guide for the Brave (or the Mad)"
date: 2025-03-01
source_url: https://nextechtide.blogspot.com/2025/03/going-in-with-rust-interview-prep-guide.html
status: imported
---

### Why Rust? (No, Seriously, Why?)
Choosing Rust as your language for a coding interview is, at best,
bold — and at worst, borderline reckless. Rust is not known for being
ergonomic under time pressure. Unlike Python or Java, it doesn’t hold
your hand when you’re fumbling through edge cases and messy input. The
compiler is famously strict, and while that’s great for production code,
it can feel like an enemy in a 45-minute interview. Forget about “just
trying something” — Rust will make you justify every move. Want to
mutate a value inside a loop? Better understand borrowing rules. Need a
linked list? Be ready to bring in `Rc`, `RefCell`, and a prayer. Want to
pass a slice around without cloning everything? Ownership will make you
earn it. Many LeetCode problems assume a fast, flexible language — Rust
is neither of those, out of the box. There’s no REPL. You can’t “just
print stuff” — not without fighting the borrow checker and formatting
macros. Even simple operations, like splitting a string, can require
ceremony (`split_whitespace`, `collect::<Vec<_>>()`, and more). Most
interviewers don’t expect Rust, and they won’t help you debug compile
errors. Worse, many LeetCode-style platforms don’t have great Rust
support or tooling. Even getting the signature right
(`fn something(nums: Vec<i32>) -> i32`) can be weirdly non-obvious at
first. You’ll spend time fighting syntax instead of solving the problem
— unless you're extremely prepared. Most coding interviews reward speed,
intuition, and fast feedback — Rust doesn’t offer that naturally. While
others are cranking out brute-force solutions in Python in under 10
minutes, you’re still fixing lifetime issues. The mental tax of tracking
ownership, lifetimes, and mutability adds up fast under pressure.  
Simply put: **Rust was built for correctness and safety — not speed and
comfort.**  
And yet… if you master it, it will be your sword and your shield — and
that’s what the rest of this guide is for. 

### Why the Hell Would You Use Rust Anyway?

Sure, Rust in an interview can feel like walking into a boxing match
with a sword no one asked for. But there *are* legitimate reasons to
bring it, as long as you know exactly what you're doing. Here’s when
choosing Rust actually makes sense — or at least isn’t totally insane:

- **The company uses Rust in production (and wants you to, too).** If
you're interviewing at a company where Rust is part of the tech stack
— say, a systems-level project, embedded software, or infrastructure
tooling — using Rust in the interview can send a strong signal. It
shows you're fluent in the company’s preferred language, and not just
as a side project. Even if it's not required, demonstrating
proficiency in Rust might earn bonus points from Rust-loving engineers
on the panel. More importantly, it helps them evaluate how you'd
actually write production code in their ecosystem. This is one of the
only times using Rust in an interview isn’t an uphill battle — it's
just smart alignment.
- **You’re applying to a role that demands control over performance,
safety, and memory.** For jobs that deal with performance-critical
paths, memory management, or low-level optimization, Rust isn't just
accepted — it’s respected. In such domains, your ability to write
zero-cost abstractions, avoid data races, and manage memory without
garbage collection becomes a competitive advantage. If your
interviewers know these constraints exist in their production
environment, seeing you code in Rust might be exactly what they want.
Plus, it gives you the opportunity to discuss real trade-offs in
safety and performance — something that scripting languages simply
abstract away. So if the role is close to the metal, Rust can help you
stand out.
- **You’re so comfortable with Rust that it’s your fastest and cleanest
language. ** Let’s be honest — this one is rare. But if you’ve written
thousands of lines of Rust, and you think in iterators, lifetimes, and
pattern matching, then using Rust might actually *reduce* your
cognitive overhead. That means you’ll write safer code, make fewer
mistakes, and stay in the flow — even under time pressure. This is
especially true if other languages now feel clunky or verbose to you
by comparison. But this reason only holds up if you’re truly fluent,
not just enthusiastic — otherwise the compiler will eat you alive.
- **You want to stand out (in a good way).** In a sea of Python and
Java solutions, a clean, efficient Rust implementation can draw
attention. It shows you're not afraid to pick the harder path if it
leads to better code — and that you care deeply about correctness and
performance. Some interviewers will respect the boldness, and if they
know Rust themselves, they might even enjoy it. But beware: standing
out only helps if your code is solid. If you're constantly fixing
borrow checker issues, you won’t seem clever — you'll seem
underprepared.
- **You’re optimizing for long-term growth, not just short-term wins.**
If your goal is to use this interview process to build serious Rust
interview muscle — perhaps because you plan to target Rust-heavy
companies long-term — then the pain might be worth it. You’ll be
forced to master Rust's most practical features, not just tinker with
toy projects. Interviewing in Rust is one of the fastest ways to
expose the gaps in your knowledge. Yes, it’s brutal. But it’s also
effective. And if you're playing the long game, that pressure might
forge real Rust fluency.

### **Back to the Primitives: Rust’s Building Blocks**

Before you implement a Trie with smart pointers and interior mutability,
you’ll be pushing numbers around and toggling booleans. Most LeetCode
problems boil down to working with primitive types, and in Rust, it pays
to know exactly how they behave — especially under pressure. This
section covers all the essential primitive types, their behavior,
conversions, and the little gotchas that can cost you precious minutes
in an interview.

------------------------------------------------------------------------

#### **Integer Types: `i32`, `i64`, `u32`, `usize`, etc.**

- Use `i32` by default unless you *know* the input size demands
something else — it's the most commonly expected integer type on
LeetCode.
- Use `usize` for indexing arrays and slices. Many methods (like
`.len()`) return `usize`, and trying to use `i32` without conversion
will cause type mismatches.

```rust
let nums: Vec<i32> = vec![1, 2, 3];
for i in 0..nums.len() {
println!("{}", nums[i]); // i is usize, nums[i] works
}
```

- Conversion between integer types:

```rust
let a: i32 = 42;
let b: usize = a as usize;
```

- Watch out for overflow — Rust panics in debug mode but silently wraps
in release unless you use `checked_*`, `wrapping_*`, or
`overflowing_*` methods.

```rust
let x: u8 = 255;
// let y = x + 1; // panic in debug!
let y = x.wrapping_add(1); // y = 0
```

------------------------------------------------------------------------

#### **Floating Point Numbers: `f32` and `f64`**

- Use `f64` unless constrained otherwise — it's the default floating
point type and avoids precision issues.
- Use `.abs()`, `.sqrt()`, `.powi()`, `.powf()` for mathematical
operations.

```rust
let x: f64 = -2.5;
println!("{}", x.abs()); // 2.5
```

- Avoid comparing floats directly due to precision issues:

```rust
let a = 0.1 + 0.2;
let b = 0.3;
println!("{}", (a - b).abs() < 1e-9); // true
```

------------------------------------------------------------------------

#### **Boolean: `bool`**

- The `bool` type is `true` or `false`, nothing fancy.
- Logical operators: `!`, `&&`, `||`

```rust
let a = true;
let b = false;
println!("{}", a && !b); // true
```

- Often used in DP arrays and visited flags for graphs, so get
comfortable with `vec![false; n]`.

------------------------------------------------------------------------

#### **Character: `char`**

- Unlike many languages, Rust’s `char` is **4 bytes** and represents a
Unicode scalar value.
- Use `.is_digit()`, `.is_alphabetic()`, `.is_uppercase()` etc. for
classification.

```rust
let c = 'a';
println!("{}", c.is_alphabetic()); // true
```

- Convert a `char` to `u8` or `usize` for indexing:

```rust
let idx = (c as u8 - b'a') as usize;
```

------------------------------------------------------------------------

#### **Copy Trait (and why it matters)**

- All primitive types implement the `Copy` trait.
- You don’t need to worry about ownership when passing them around —
they’re cheap and copyable.

```rust
fn add(a: i32, b: i32) -> i32 {
a + b // no need to borrow or move
}
```

------------------------------------------------------------------------

#### **Useful Standard Methods**

- `i32::MAX`, `i64::MIN` — handy when simulating integer bounds.
- `.abs()`, `.signum()` — quick sign logic.
- `.count_ones()`, `.leading_zeros()` — useful in bit manipulation
problems.
- `.to_string()` and `str::parse()` for converting between strings and
primitives.

```rust
let n = 42;
let s = n.to_string();
let m: i32 = s.parse().unwrap();
```

------------------------------------------------------------------------

#### **When Types Don’t Match: Fixing Quickly**

- `.clone()` is rarely needed with primitives — just cast or convert
directly.
- Most type mismatches are between `usize` and `i32`, especially in
loops.
- Use `as` for fast casting:

```rust
let i: usize = 0;
let j: i32 = i as i32;
```

------------------------------------------------------------------------

#### **Finding `min` / `max` Between Numbers**

- Use `std::cmp::min` and `std::cmp::max` for comparing two values:

```rust
use std::cmp;

let a = 10;
let b = 42;
let smaller = cmp::min(a, b);
let larger = cmp::max(a, b);
```

- You can also use the `.min()` and `.max()` **methods** when chaining
or comparing more than two values:

```rust
let result = a.max(b).max(c); // find max of three numbers
```

- These are **pure functions**, work for any type that implements `Ord`,
and are great for clean, readable comparisons.

- Avoid writing your own `if-else` blocks for simple min/max logic —
these are faster, cleaner, and more idiomatic.

### **String Theory (The LeetCode Edition)**

Strings are everywhere in LeetCode — from classic problems like “Reverse
Words in a String” to more nuanced ones like “Valid Palindrome” or
“Implement strStr()”. Rust strings are fast, safe, and Unicode-correct —
but they’re also **more explicit and strict** than in most languages. If
you don’t know how to handle `String` and `&str` properly, your time
will be devoured by type mismatches, lifetime errors, and panics on
invalid indexing. This section gives you everything you need to treat
strings as tools, not traps.

------------------------------------------------------------------------

#### **String vs. &str (Heap vs. Stack Storage)**

Rust has two main string types: `String` and `&str`.  
A `String` is an owned, heap-allocated growable string. It’s like
`Vec<u8>` under the hood with UTF-8 semantics. You use it when you need
to build or mutate strings.  
On the other hand, `&str` is a string **slice** — a borrowed view into a
string. It’s usually what you get from string literals (`"hello"`) or
when slicing another string.  
Most standard library functions accept `&str`, so you often borrow a
`String` rather than clone or convert it.  
Knowing when to use each (and how to switch between them) is key to
avoiding unnecessary allocations or compiler complaints.

------------------------------------------------------------------------

#### **Converting Between `String` and `&str`**

To convert a `String` to a `&str`, just borrow it with `&`. This is
zero-cost and preferred:

```rust
let s: String = String::from("hello");
let slice: &str = &s;
```

To go the other way — from `&str` to `String` — you allocate with
`.to_string()` or `String::from()`:

```rust
let s: &str = "hello";
let owned: String = s.to_string();
```

Use `to_owned()` as a shortcut for `to_string()` when cloning a
`&str`.  
Conversions like these are common when passing data to functions or
returning owned strings from algorithms.

------------------------------------------------------------------------

#### **Splitting a String (`split()`, `split_whitespace()`)**

Splitting strings is a core operation for problems like “Reverse Words
in a String” or token parsing.  
Use `.split()` when you need to divide based on a specific delimiter
(like commas or semicolons):

```rust
let s = "a,b,c";
let parts: Vec<&str> = s.split(',').collect();
```

Use `.split_whitespace()` when breaking on arbitrary spaces, tabs, or
line breaks:

```rust
let input = " hello   world\tfrom rust ";
let words: Vec<&str> = input.split_whitespace().collect(); // ["hello", "world", "from", "rust"]
```

These methods are lazy iterators, so you can filter, map, or count
tokens without collecting if needed.  
Always remember that split returns borrowed `&str` slices, not owned
`String`s.

------------------------------------------------------------------------

#### **Reversing a String (`chars().rev().collect()`)**

Rust strings can’t be reversed by indexing due to UTF-8 encoding.  
Instead, use the `.chars()` iterator, which yields Unicode `char`s (not
bytes), then `.rev()` and `.collect()` to build a new string:

```rust
let reversed: String = "rust".chars().rev().collect(); // "tsur"
```

This is useful for palindrome problems or any reverse-based
manipulation.  
Be cautious — reversing graphemes (emoji, accents) is **not the same**
as reversing chars, but for LeetCode purposes, `chars()` usually does
the job.  
If performance matters and the string is ASCII-only, you might choose
`as_bytes()` instead for raw byte reversal.

------------------------------------------------------------------------

#### **Converting a String to Bytes (`as_bytes()`)**

Use `.as_bytes()` to get a byte slice (`&[u8]`) from a `String` or
`&str`:

```rust
let s = "abc";
let b = s.as_bytes(); // &[97, 98, 99]
```

This is essential in problems that involve hashing, XOR, or byte-level
operations.  
Since strings in Rust are UTF-8 encoded, each `char` may take multiple
bytes, so be careful when working at this level.  
You can safely slice bytes only at valid UTF-8 boundaries — invalid
slicing will panic at runtime.  
Use `.bytes()` iterator if you want to iterate over each byte instead of
getting a slice.

------------------------------------------------------------------------

#### **Efficient String Searching (`find()`, `contains()`)**

Use `.find()` to locate the first index of a substring:

```rust
let s = "rustacean";
if let Some(pos) = s.find("ace") {
println!("Found at index: {}", pos);
}
```

Use `.contains()` to simply check presence:

```rust
if s.contains("ace") {
println!("It’s in there!");
}
```

Both are fast and safe — great for problems like implementing `strStr()`
or substring search.  
These functions operate on `&str` and are Unicode-safe.  
Keep in mind that positions returned by `.find()` refer to **byte
offsets**, not character indices.

------------------------------------------------------------------------

#### **Concatenation (`push()`, `push_str()`)**

To build strings incrementally, use `.push(char)` and `.push_str(&str)`:

```rust
let mut result = String::new();
result.push('a');
result.push_str("bc");
```

This is efficient and avoids unnecessary allocations, especially in
string-building problems like "Zigzag Conversion" or "Longest Common
Prefix".  
Don’t use `+` unless you know what you’re doing — it consumes the
left-hand `String`, which may not be what you want:

```rust
let s = String::from("a") + "b"; // s is now "ab", but the original left-hand `String` is moved
```

If you need to combine many strings, consider `format!()` or collect
from an iterator.

------------------------------------------------------------------------

#### **Pattern Matching with Strings (`starts_with()`, `ends_with()`)**

For prefix/suffix problems (e.g., “Longest Common Prefix”), use:

```rust
let s = "rustacean";
s.starts_with("rust"); // true
s.ends_with("cean");   // true
```

These are more readable and safer than manually slicing strings.  
They also avoid panic risks from invalid index slicing.  
You can even match against `char` or pattern tuples (like a list of
prefixes).  
These functions work with any `&str` — no need to convert or allocate.

------------------------------------------------------------------------

#### **Converting String to Numbers**

Use `.parse::<T>()` to convert strings to numbers. You must annotate the
type, or use `turbofish` (`::<i32>`):

```rust
let s = "42";
let n: i32 = s.parse().unwrap();
```

This is critical for reading input when numbers are space-separated
strings.  
For bulk conversion, map over a split iterator:

```rust
let input = "1 2 3";
let nums: Vec<i32> = input.split_whitespace().map(|s| s.parse().unwrap()).collect();
```

Always handle parsing carefully — `unwrap()` will panic if the input is
malformed.

------------------------------------------------------------------------

#### **Formatting Strings**

Use `format!()` to create a new string with embedded values:

```rust
let name = "Rust";
let s = format!("Hello, {}!", name);
```

This is like `println!()` but returns a `String` instead of printing.  
It’s great for cleanly building strings, especially in problems where
you need to return a custom message or formatted output.  
Supports `{}` for default display, and `{:?}` for debug output.  
Also allows width, alignment, and precision settings.

------------------------------------------------------------------------

#### **Creating a String from Bytes**

You can build a `String` from bytes using `String::from_utf8()` — this
is **fallible**, because invalid UTF-8 is possible:

```rust
let bytes = vec![104, 101, 108, 108, 111];
let s = String::from_utf8(bytes).unwrap(); // "hello"
```

Use this when you're manipulating data at the byte level (e.g.,
decoding, binary protocols).  
If you're certain the bytes are valid UTF-8, `from_utf8_unchecked()` can
skip checks (unsafe).  
Never blindly convert arbitrary bytes — malformed UTF-8 will cause
runtime panics.  
For ASCII-only input, this method is safe and convenient.

------------------------------------------------------------------------

#### **Removing Whitespace (`trim()`, `trim_start()`, `trim_end()`)**

Whitespace cleanup is essential in problems like “Reverse Words in a
String”, or any case where you're normalizing input.

- `.trim()` removes **leading and trailing** whitespace (spaces, tabs,
newlines, etc.):

```rust
let raw = "   hello world   ";
let cleaned = raw.trim(); // "hello world"
```

- Use `.trim_start()` or `.trim_end()` to target just one side:

```rust
let s = "   hello ";
let left = s.trim_start(); // "hello "
let right = s.trim_end();   // "   hello"
```

- These methods return `&str`, so they don’t allocate — use them inline
or convert to `String` if needed:

```rust
let owned = s.trim().to_string();
```

This is critical when parsing input strings or validating formats —
always sanitize before processing.

------------------------------------------------------------------------

#### **Changing Case (`to_lowercase()`, `to_uppercase()`)**

Case conversion is common in string normalization, anagram problems, and
input validation.

- Use `.to_lowercase()` or `.to_uppercase()` on `String` or `&str`:

```rust
let s = "RustLang";
let lower = s.to_lowercase(); // "rustlang"
let upper = s.to_uppercase(); // "RUSTLANG"
```

- These return new `String` values — they allocate, so don’t overuse in
tight loops.

- Works properly with Unicode (so “ß”.to_uppercase() becomes “SS”).

- For individual `char`s, you can also use:

```rust
let c = 'R';
let lc: String = c.to_lowercase().collect();
```

Case conversion is especially useful in problems like “Valid Anagram”,
“Palindrome”, and case-insensitive matching.

------------------------------------------------------------------------

#### **Iterating Over Characters (`.chars()`)**

Use `.chars()` when you want to process each Unicode scalar value (e.g.
letter, digit, emoji, etc.).

```rust
let s = "hello";
for c in s.chars() {
println!("{}", c); // 'h', 'e', 'l', 'l', 'o'
}
```

- Returns `char` values — not bytes.
- Good for checking characters one-by-one (`is_digit`, `is_alphabetic`,
palindrome checks, etc.).
- Safe for Unicode, but **cannot be indexed directly** —
`.chars().nth(i)` is **O(n)**, not constant-time.

------------------------------------------------------------------------

#### **Iterating Over Bytes (`.bytes()`)**

Use `.bytes()` when you're only dealing with **ASCII** strings or need
raw byte access.

```rust
let s = "abc";
for b in s.bytes() {
println!("{}", b); // 97, 98, 99
}
```

- Each item is a `u8`.
- Perfect for problems that assume lowercase letters (`a` to `z`),
binary strings, or ASCII-only content.
- Much faster than `chars()` for these cases, and allows **random
access** via `.as_bytes()`.

------------------------------------------------------------------------

#### **Accessing an Arbitrary Character**

⚠️ Rust **does not allow direct indexing** of `String` or `&str` like
`s[3]`. This would panic or be a compile error, because Rust strings are
UTF-8 and each character can take variable bytes.

##### **Slow (but safe): `.chars().nth(i)`**

```rust
let c = s.chars().nth(2).unwrap();
```

- This is O(n) time, so avoid it in performance-critical loops.

##### **Faster Alternative: Convert to `Vec<char>`**

```rust
let chars: Vec<char> = s.chars().collect();
let c = chars[2];
```

- Allows fast random access (`O(1)`), at the cost of allocation and
memory.
- Best used when you need to access the same string multiple times by
index (e.g. in a palindrome loop).

##### **Fastest (ASCII-only): Use `.as_bytes()`**

```rust
let s = "abc";
let b = s.as_bytes();
let c = b[1] as char; // 'b'
```

- Works **only** if you're guaranteed the string is ASCII (LeetCode
often makes this assumption).
- Super efficient and indexable.
- Use for problems involving lowercase letters, digits, etc.

------------------------------------------------------------------------

### **Arrays and Slices: Rust’s Core Data Structures**

In LeetCode challenges, efficient data manipulation is crucial, and
Rust's arrays and slices are fundamental tools in your arsenal.
Understanding their nuances, from initialization to iteration, can
significantly enhance your problem-solving efficiency. This section
delves into the essential operations and methods associated with arrays
and slices in Rust, ensuring you're well-prepared for any related
challenges.

------------------------------------------------------------------------

#### **Understanding Arrays and Slices in Rust**

- **Arrays** are fixed-size collections of elements of the same type,
stored contiguously in memory. Their size is known at compile time,
making them stack-allocated and highly efficient for scenarios where
the number of elements is constant.

```rust
let arr: [i32; 5] = [1, 2, 3, 4, 5];
```

- **Slices** are dynamically-sized views into arrays or other sequences.
They allow for referencing a contiguous sequence of elements without
owning them, making them versatile for various operations where the
size isn't known at compile time.

```rust
let slice: &[i32] = &arr[1..4]; // Contains elements [2, 3, 4]
```

Understanding when to use arrays versus slices is pivotal. Arrays offer
performance benefits due to their fixed size, while slices provide
flexibility, especially when dealing with subsets of data or when
interfacing with functions that operate on sequences of varying lengths.

------------------------------------------------------------------------

#### **Initialization and Access**

- **Initializing Arrays:**

- **With Specific Values:**
```rust
let arr = [1, 2, 3, 4, 5];
```

- **With Default Values:**
```rust
let zeros = [0; 5]; // [0, 0, 0, 0, 0]
```

- **Accessing Elements:**

- **By Index:**
```rust
let first = arr[0]; // Accesses the first element
```
Rust performs bounds checking at runtime, ensuring safety by
preventing out-of-bounds access, which would result in a panic.

- **Slicing:**
```rust
let slice = &arr[1..4]; // Contains elements [2, 3, 4]
```
Slices provide a view into a portion of the array without copying
data, which is efficient for operations requiring subsets of data.

------------------------------------------------------------------------

#### **Iterating Over Arrays and Slices**

- **Using `for` Loops:**

```rust
for &item in &arr {
println!("{}", item);
}
```

Borrowing the array or slice allows for iteration without transferring
ownership, maintaining the integrity of the original data.

- **Enumerating Indices and Values:**

```rust
for (index, &value) in arr.iter().enumerate() {
println!("Index: {}, Value: {}", index, value);
}
```

This approach is particularly useful when the position of each element
is significant, such as in searching or sorting algorithms.

------------------------------------------------------------------------

#### **Common Operations and Methods**

- **Finding Elements:**

- **Checking for Existence:**
```rust
if arr.contains(&target) {
println!("Element found!");
}
```
The `contains` method provides a concise way to verify the presence
of an element.

- **Finding Position:**
```rust
if let Some(pos) = arr.iter().position(|&x| x == target) {
println!("Element found at position {}", pos);
}
```
Determining the index of an element is essential in scenarios where
the position dictates subsequent operations.

- **Sorting:**

- **In-Place Sorting:**
```rust
let mut arr = [3, 1, 4, 1, 5];
arr.sort();
```
Sorting is a common operation in problems requiring ordered data,
such as merging intervals or finding medians.

- **Custom Sorting:**
```rust
arr.sort_by(|a, b| b.cmp(a)); // Sorts in descending order
```
Custom sorting allows for flexibility in ordering criteria,
accommodating problem-specific requirements.

- **Reversing:**

- **In-Place Reversal:**
```rust
arr.reverse();
```
Reversing an array or slice is often utilized in problems involving
palindrome checks or reversing sequences.

- **Splitting:**

- **Based on a Predicate:**
```rust
let parts: Vec<&[i32]> = arr.split(|&x| x == delimiter).collect();
```
Splitting is useful in partitioning data based on specific
conditions, aiding in problems that require segmenting input.

------------------------------------------------------------------------

#### **Conversion Between Arrays, Slices, and Vectors**

- **From Array to Slice:**

```rust
let slice: &[i32] = &arr;
```

Slices provide a view into arrays without ownership, facilitating
functions that operate on sequences without requiring ownership
transfer.

- **From Slice to Vector:**

```rust
let vec: Vec<i32> = slice.to_vec();
```

Converting slices to vectors is beneficial when dynamic resizing or
ownership of the data is needed.

- **From Vector to Slice:**

```rust
let slice: &[i32] = &vec;
```

Borrowing a vector as a slice allows for read-only access to its
elements, useful in contexts where mutation isn't required.

------------------------------------------------------------------------

#### **Safety and Performance Considerations**

- **Bounds Checking:** Rust ensures safety by performing bounds checking
during element access. While this prevents common errors like buffer
overflows, it's essential to be mindful of potential performance
implications in performance-critical sections.

- **Mutability:** To modify elements within an array or slice, ensure
they are declared as mutable:

```rust
let mut arr = [1, 2, 3];
arr[0] = 10;
```

Mutability allows for in-place modifications, which is efficient in
scenarios requiring frequent updates to the data.

- **Borrowing vs. Owning:** Understanding when to borrow (`&[T]`) versus
when to own (`Vec<T>`) is crucial. Borrowing is efficient and avoids
unnecessary allocations, while owning is necessary when the data needs
to be modified or stored beyond the current scope.

------------------------------------------------------------------------

#### **Getting the Length of an Array or Slice**

**Fixed-Size Arrays**

You can use `.len()` to get the number of elements in a fixed-size
array:

```rust
let arr = [10, 20, 30];
println!("{}", arr.len()); // Output: 3
```

- `arr.len()` returns a `usize`.
- This works even though the size is known at compile time.
- Safe, fast, and constant time.

**Slices**

Slices (`&[T]`) also use `.len()` to return their length:

```rust
let slice = &arr[1..];
println!("{}", slice.len()); // Output: 2
```

- `.len()` on slices returns how many elements are visible through the
slice.
- Very useful when iterating, partitioning, or checking edge cases.

------------------------------------------------------------------------

#### **When to Use `.len()` in LeetCode Problems**

- **Looping:**

```rust
for i in 0..arr.len() {
// safe, bounds-checked access
}
```

- **Early Returns:**

```rust
if arr.len() < 2 {
return false;
}
```

- **Slice validation:**

```rust
if &arr[..3].len() == 3 {
// do something
}
```

------------------------------------------------------------------------

### **Vec: The Workhorse of Rust**

When it comes to solving LeetCode problems in Rust, `Vec<T>` is your
best friend. It’s the standard growable, heap-allocated array type —
essentially what Python and Java call a list or an ArrayList. Almost
every single LeetCode problem involving dynamic data structures will use
`Vec`. If you master it, you’ll write cleaner, safer, and more
performant solutions. This section covers **everything you need to
know** about `Vec` in an interview setting — no fluff, no missed
essentials.

------------------------------------------------------------------------

#### **Creating Vectors**

```rust
let empty: Vec<i32> = Vec::new();              // Explicit type
let filled = vec![1, 2, 3];                    // Macro, preferred
let zeros = vec![0; 5];                        // [0, 0, 0, 0, 0]
```

- Use `vec![...]` macro for clarity and brevity.
- Use `vec![value; n]` to initialize with repeated values — great for DP
tables, visited arrays, and zero-initialized input buffers.

------------------------------------------------------------------------

#### **Accessing Elements**

```rust
let v = vec![1, 2, 3];
let first = v[0];              // Panics on out-of-bounds
let maybe = v.get(5);          // Returns Option<&T>
```

- Use `v.get(i)` in edge-case-prone code to avoid panics.
- Indexing (`v[i]`) is okay when you’ve guaranteed bounds.
- For mutable access: `v[i] = new_value;`

------------------------------------------------------------------------

#### **Modifying Vectors**

```rust
let mut v = vec![1, 2, 3];
v.push(4);                     // Append
v.pop();                       // Remove last (returns Option<T>)
v.insert(1, 99);               // Insert at index
v.remove(0);                   // Remove and shift (O(n))
v.swap_remove(0);              // Remove and swap with last (O(1))
v.clear();                     // Empty the vector
```

- Use `swap_remove()` when order doesn’t matter — it’s much faster.
- Avoid `insert`/`remove` in the middle of the vector unless necessary —
costly in large vectors.
- `push()` and `pop()` are constant-time and safe to use often.

------------------------------------------------------------------------

#### **Iterating and Enumerating**

```rust
for val in &v { ... }                   // Immutable borrow
for val in &mut v { *val += 1; }        // Mutable borrow
for (i, val) in v.iter().enumerate() { ... } // With index
```

- Iterating with `enumerate()` is perfect for index-based logic.
- Iterators avoid unnecessary cloning and are more idiomatic than
traditional `for i in 0..v.len()` loops (but both are fine).

------------------------------------------------------------------------

#### **Transforming and Collecting**

```rust
let squares: Vec<_> = v.iter().map(|&x| x * x).collect();
```

- Chain `.map()`, `.filter()`, `.collect()` for fast transformations.
- When mapping by value (`x * x`), make sure to dereference or use
`copied()`.

------------------------------------------------------------------------

#### **Searching and Filtering**

```rust
v.contains(&3);                             // true/false
v.iter().position(|&x| x == target);        // Some(index) or None
v.iter().any(|&x| x % 2 == 0);              // true if any match
v.iter().all(|&x| x > 0);                   // true if all match
v.iter().find(|&&x| x > 5);                 // Returns Option<&T>
```

- These methods are ideal for interview problems like “contains
duplicates”, “first missing positive”, or “search insert position”.

------------------------------------------------------------------------

#### **Sorting and Reversing**

```rust
v.sort();                                   // Ascending
v.sort_by(|a, b| b.cmp(a));                 // Descending
v.reverse();                                // In-place reversal
```

- `.sort()` is stable and fast — use it for most problems that involve
ordering.
- For descending order, use `.sort_by()` with `cmp()`.
- `.reverse()` is often used in conjunction with two-pointer techniques
or reversing segments.

------------------------------------------------------------------------

#### **Deduplication and Retention**

```rust
v.dedup();                                  // Removes consecutive duplicates
v.retain(|&x| x % 2 == 0);                  // Keeps even numbers
```

- `dedup()` only removes **adjacent** duplicates — sort first if needed.
- `retain()` is a powerful way to filter in-place, especially in array
cleanup problems.

------------------------------------------------------------------------

#### **Capacity and Optimization**

```rust
v.reserve(100);                             // Pre-allocates capacity
v.shrink_to_fit();                          // Reduce memory usage
```

- Rarely needed in interviews, but useful for optimizing performance in
large input problems.

------------------------------------------------------------------------

#### **Binary Search (on sorted vectors)**

```rust
let idx = v.binary_search(&target); // Ok(index) or Err(insert_pos)
```

- Only works on **sorted** vectors.
- Returns `Result<usize, usize>`, which gives you powerful insert-point
logic.

------------------------------------------------------------------------

#### **Cloning and Copying**

```rust
let copy = v.clone();                       // Deep clone
let slice_copy = v[..3].to_vec();           // Clone a slice into Vec
```

- Use `clone()` when passing the vector by value and retaining the
original.
- Avoid cloning inside hot loops unless absolutely necessary — prefer
references or slices when possible.

------------------------------------------------------------------------

#### **Multi-dimensional Vectors**

```rust
let grid: Vec<Vec<i32>> = vec![vec![0; cols]; rows];
```

- Common in matrix problems like “Number of Islands” or “Unique Paths”.
- You can also mutate them like: `grid[i][j] = 1;`

------------------------------------------------------------------------

#### **Splitting, Chunking, and Windowing**

```rust
v.windows(3);       // Overlapping sliding window of 3 elements
v.chunks(2);        // Non-overlapping chunks of 2
v.split(|&x| x == 0); // Split on condition
```

- `.windows(n)` is vital for sliding window problems.
- `.chunks(n)` can help in decoding/encoding problems (e.g., grouping).
- `.split()` is helpful in partitioning logic — it returns slices.

------------------------------------------------------------------------

### **HashMap and HashSet: Rust’s Secret Weapons**

If `Vec` is your everyday hammer, then `HashMap` and `HashSet` are your
lockpick and crowbar. These tools unlock elegant, fast solutions to some
of the trickiest LeetCode problems — like frequency counting, duplicate
detection, memoization, and mapping relationships. In Rust, they live in
`std::collections`, and they come with quirks and power you need to know
cold. Let’s break down what makes them essential, and how to wield them
like a pro.

------------------------------------------------------------------------

#### 🔑 **Import First**

```rust
use std::collections::{HashMap, HashSet};
```

Always bring them in — you’ll use one or both in at least half of
real-world LeetCode problems.

------------------------------------------------------------------------

### 🧠 **HashMap: The Brain Behind Counting and Mapping**

#### **Creating and Inserting**

```rust
let mut map = HashMap::new();
map.insert("apple", 3);
map.insert("banana", 2);
```

- Keys and values can be any types that implement `Eq` and `Hash`.
- Common for counting occurrences (`i32`, `&str`, `char`) or mapping
values (`index → value`).

------------------------------------------------------------------------

#### **Accessing Values**

```rust
if let Some(count) = map.get("apple") {
println!("Count: {}", count);
}
```

- `.get()` returns an `Option<&V>` — be ready to `unwrap()` or
pattern-match.
- Use `contains_key()` to check for presence.

------------------------------------------------------------------------

#### **Counting Frequencies**

```rust
let mut freq = HashMap::new();
for &num in &[1, 2, 1, 3, 1] {
*freq.entry(num).or_insert(0) += 1;
}
```

- This is the idiomatic way to count elements — the `entry()` API is
incredibly powerful.
- `or_insert(default)` inserts if missing and gives you a mutable
reference.
- You’ll use this pattern in problems like:
- **Top K Frequent Elements**
- **Group Anagrams**
- **Majority Element**

------------------------------------------------------------------------

#### **Iterating Over a HashMap**

```rust
for (key, val) in &map {
println!("{}: {}", key, val);
}
```

- The order is **not guaranteed** — if you need ordering, use
`BTreeMap`.

------------------------------------------------------------------------

#### **Removing Entries**

```rust
map.remove("banana");
```

- Returns `Some(value)` if it existed.

------------------------------------------------------------------------

### 🧱 **HashSet: Unique Elements, Fast Lookups**

#### **Creating and Inserting**

```rust
let mut set = HashSet::new();
set.insert("rust");
set.insert("go");
```

- Like `HashMap<K, ()>` under the hood.
- Use for de-duplication, visited-tracking, and uniqueness checks.

------------------------------------------------------------------------

#### **Checking for Existence**

```rust
if set.contains("rust") {
println!("Found!");
}
```

- Super fast O(1) average-case lookup.

------------------------------------------------------------------------

#### **Removing Elements**

```rust
set.remove("go");
```

- Works exactly like `.insert()` — simple and efficient.

------------------------------------------------------------------------

#### **Converting from Vec to Set**

```rust
let nums = vec![1, 2, 2, 3];
let uniq: HashSet<_> = nums.into_iter().collect();
```

- Instantly remove duplicates from a vector.
- Useful for:
- **Contains Duplicate**
- **Intersection of Two Arrays**
- **Happy Number**
- **Longest Consecutive Sequence**

------------------------------------------------------------------------

#### ⚠️ **Pitfalls to Avoid**

- **Type inference issues** — sometimes you’ll need to explicitly
declare the `HashMap<i32, i32>` or `HashSet<char>` type.
- **Borrow checker** — if you mutate while iterating, use `.clone()` or
`.into_iter()`.
- **Don’t forget `mut`** — you need `mut` to insert, remove, or modify.
- **Order matters? Use `BTreeMap` instead** — `HashMap` is unordered.

------------------------------------------------------------------------

#### ✨ **Bonus: Set Intersection & Union**

```rust
let a: HashSet<_> = vec![1, 2, 3].into_iter().collect();
let b: HashSet<_> = vec![2, 3, 4].into_iter().collect();

let intersection: HashSet<_> = a.intersection(&b).cloned().collect();
let union: HashSet<_> = a.union(&b).cloned().collect();
```

- Useful in problems that involve merging or comparing element groups.

------------------------------------------------------------------------

### **Sorting and Searching: Rust’s Power Tools for Algorithmic Problems**

Sorting and binary search are at the heart of hundreds of LeetCode
problems. Whether you're merging intervals, finding medians, or solving
two-pointer problems, you’ll be sorting and searching all the time. Rust
gives you **efficient, expressive, and safe** tools for this — but they
come with a few sharp edges. This section covers everything you need to
confidently sort, search, and slice your way through LeetCode challenges
using the standard library.

------------------------------------------------------------------------

#### **Sorting a Vector (`sort()`, `sort_by()`)**

Rust’s `.sort()` method works on mutable vectors and slices. It uses an
efficient, stable sort (TimSort).

```rust
let mut nums = vec![3, 1, 4, 2];
nums.sort();
println!("{:?}", nums); // [1, 2, 3, 4]
```

- Always requires a **mutable** vector or slice.
- Only works if the type implements the `Ord` trait (integers, strings,
tuples, etc.).
- Panics if you try to call it on an immutable vector — don’t forget
`mut`.

------------------------------------------------------------------------

#### **Custom Sorting with `sort_by()`**

When you need full control over sorting behavior, use `.sort_by()` with
a comparison function.

```rust
let mut nums = vec![1, 3, 2];
nums.sort_by(|a, b| b.cmp(a)); // Descending
```

- Use `cmp()` to compare values.
- You can sort by any custom logic: length, frequency, absolute value,
etc.
- Great for problems like:
- **Sort Characters by Frequency**
- **Reorder Data in Log Files**
- **Meeting Rooms**

------------------------------------------------------------------------

#### **Custom Key Sorting with `sort_by_key()`**

A simpler way to sort by some derived value — great for sorting structs,
tuples, or based on a single field.

```rust
let mut words = vec!["apple", "banana", "kiwi"];
words.sort_by_key(|s| s.len());
println!("{:?}", words); // ["kiwi", "apple", "banana"]
```

- Cleaner than `sort_by()` when sorting by a single attribute.
- Very useful for LeetCode problems where you're sorting objects,
strings, or coordinates.

------------------------------------------------------------------------

#### **Binary Search with `binary_search()`**

Rust’s built-in binary search is fast, easy to use, and doesn’t require
external libraries — but it assumes the vector is sorted.

```rust
let nums = vec![1, 3, 5, 7, 9];
match nums.binary_search(&5) {
Ok(i) => println!("Found at index {}", i),
Err(pos) => println!("Not found, insert at {}", pos),
}
```

- Returns `Result<usize, usize>`:
- `Ok(index)` if found
- `Err(insert_position)` if not found
- Excellent for:
- **Search Insert Position**
- **Find Minimum in Rotated Sorted Array**
- **Kth Missing Positive Number**
- `.binary_search()` uses full equality. For more flexible logic, you
can use `.partition_point()`.

------------------------------------------------------------------------

#### **Partial Searching with `partition_point()`**

`partition_point()` finds the first index in a sorted slice where a
predicate becomes true. This is **powerful** for range-based problems.

```rust
let nums = vec![1, 3, 5, 7, 9];
let idx = nums.partition_point(|&x| x < 6);
println!("{}", idx); // 3 → 7 is the first not < 6
```

- Think of it as a **custom binary search** over a boolean condition.
- It's perfect for questions like:
- “Find the first element greater than X”
- “Find how many elements are less than X”
- “Find insert position for a predicate”
- Available in **Rust 1.52+**.

------------------------------------------------------------------------

#### **Finding Min and Max (`min()`, `max()`)**

Rust gives you two clean ways to find the smallest or largest element in
a collection.

#### **Compare Two Values**

```rust
use std::cmp::{min, max};

let a = 3;
let b = 7;
println!("{}", min(a, b)); // 3
```

#### **Find in a Collection**

```rust
let nums = vec![2, 4, 1, 9];
let min_val = nums.iter().min(); // Option<&i32>
let max_val = nums.iter().max();
```

- Returns an `Option<&T>` — be sure to handle `None` in edge cases.
- Useful for problems like:
- **Find Peak Element**
- **Minimum Window Substring**
- **Maximum Subarray**

------------------------------------------------------------------------

#### 💡 **Pro Tips**

- Sort before using two pointers or sliding window techniques.
- Use `.clone()` if you need to preserve the original vector.
- Use `.as_slice()` if a function expects a slice (`&[T]`) instead of a
vector.
- Avoid sorting inside loops — sort once and reuse.
- `.binary_search()` and `.partition_point()` are zero-allocation and
fast — use them instead of writing custom search code.



### **Pattern Matching: Rust’s Swiss Army Knife**

Pattern matching in Rust isn’t just syntax sugar — it’s a core part of
how the language thinks. It’s used in everything from destructuring
input, handling `Option` and `Result`, matching tuples, branching over
enums, and simplifying control flow. While it's not *required* to solve
LeetCode problems, it **makes your code cleaner, safer, and more
expressive**, especially when you’re dealing with nested data, edge
cases, or structured input.

If you want to write Rust that feels natural (and not like C in
disguise), you need to embrace pattern matching.

------------------------------------------------------------------------

#### **The `match` Statement**

Rust’s `match` is exhaustive — you must handle all possible cases. This
avoids runtime surprises and makes intent explicit.

#### **Matching Values**

```rust
let x = 3;
match x {
0 => println!("zero"),
1..=4 => println!("between 1 and 4"),
_ => println!("something else"),
}
```

- Use ranges (`1..=4`), exact matches, and the wildcard `_`.
- No fallthrough like `switch` in C — each arm is independent.

------------------------------------------------------------------------

#### **Matching `Option<T>`**

This is where pattern matching shines in everyday Rust.

```rust
let maybe = Some(42);
match maybe {
Some(val) => println!("Got {}", val),
None => println!("Nothing there"),
}
```

Much cleaner than unwrapping or panicking. Essential in problems
involving optional values (like searching or parsing).

------------------------------------------------------------------------

### **`if let` and `while let`: Cleaner Alternatives**

When you only care about one match case (usually `Some(_)`), use
`if let`:

```rust
if let Some(val) = maybe {
println!("Found {}", val);
}
```

For loops that extract values from an iterator or state:

```rust
while let Some(x) = stack.pop() {
println!("{}", x);
}
```

These are very common in DFS, BFS, or stack-based problems.

------------------------------------------------------------------------

#### **Matching Tuples**

In many LeetCode problems, you’ll be storing state as `(index, value)`
or `(row, col)` pairs. Pattern matching makes accessing them trivial.

```rust
let pair = (2, 5);
match pair {
(x, 5) => println!("Second is 5, first is {}", x),
(0, _) => println!("First is zero"),
_ => println!("Other pair"),
}
```

You can destructure tuples **right inside the `match`** — no `.0` and
`.1` needed.

------------------------------------------------------------------------

#### **Destructuring in Loops and Let-Bindings**

Destructure inline with `let` or `for`:

```rust
let (a, b) = (1, 2);
for (i, val) in vec.iter().enumerate() {
println!("Index {}, value {}", i, val);
}
```

This keeps your logic clean and close to the data.

------------------------------------------------------------------------

#### **Pattern Matching with Structs and Enums**

Not super common in LeetCode, but worth knowing if you're building
helpers or solving problems involving your own types.

```rust
enum Direction {
Up,
Down,
Left,
Right,
}

let dir = Direction::Left;
match dir {
Direction::Left => println!("Going left"),
Direction::Right => println!("Right"),
_ => println!("Vertical movement"),
}
```

------------------------------------------------------------------------

#### **Using Guards in Match Arms**

Add extra logic to a pattern with `if` guards:

```rust
match x {
n if n % 2 == 0 => println!("even"),
_ => println!("odd"),
}
```

Or more idiomatically:

```rust
match x {
n if n > 100 => println!("large"),
n => println!("normal: {}", n),
}
```

Useful for catching edge cases cleanly in one line.

------------------------------------------------------------------------

#### 🔥 **Pro Tips**

- Use `_` to ignore values you don’t care about.
- Combine with `ref`, `mut`, and destructuring for precise control.
- Never `unwrap()` blindly — match or `if let` is always safer.
- Combine pattern matching with recursion and functional methods for
expressive solutions.

------------------------------------------------------------------------

### **Iterators & Functional Tools: Solving Problems Without the For Loop**

Rust’s iterator system is one of the most elegant and expressive parts
of the language. It lets you write **declarative**, **readable**, and
often **faster** code — ideal for the kinds of data transformation-heavy
problems you’ll see on LeetCode. And while you *can* solve everything
with traditional `for` loops, using iterators like `map`, `filter`,
`collect`, and `fold` will make your code more idiomatic and often
cleaner under time pressure. In this section, we’ll walk through the
**functional core** of Rust’s standard library — everything you need to
know to manipulate collections like a pro.

------------------------------------------------------------------------

#### 🔄 **Transforming Collections: `map()`, `filter()`, `collect()`**

These are your go-to methods for converting, cleaning, and reshaping
vectors — a constant task in LeetCode.

**Mapping**

```rust
let nums = vec![1, 2, 3];
let squares: Vec<i32> = nums.iter().map(|x| x * x).collect();
```

- `.map()` applies a function to each element.
- You’ll often see `.iter().map(|&x| ...)` for primitive values — `|&x|`
dereferences from `&i32` to `i32`.

**Filtering**

```rust
let evens: Vec<_> = nums.iter().copied().filter(|x| x % 2 == 0).collect();
```

- `.filter()` keeps only the values that match a condition.
- Use `.copied()` if you want to avoid working with `&i32`.

**Collecting**

- `.collect()` turns an iterator back into a collection (like `Vec`,
`HashSet`, `HashMap`, etc.).
- Use `collect::<Vec<_>>()` or let type inference do the work.

These tools are ideal for:

- **Removing duplicates**
- **Building frequency maps**
- **Cleaning input data**
- **Transforming characters into ASCII values**

------------------------------------------------------------------------

#### ➕ **Reducing Elements: `sum()`, `product()`, `fold()`**

Aggregating values is a common task: summing arrays, multiplying digits,
building cumulative results.

**Summing and Multiplying**

```rust
let nums = vec![1, 2, 3];
let total: i32 = nums.iter().sum();         // 6
let product: i32 = nums.iter().product();   // 6
```

- Use `.iter()` when reducing without consuming.
- Can also call `.into_iter()` to consume if you don’t need the
original.

**Folding**

```rust
let sentence = vec!["Rust", "is", "fun"];
let joined = sentence.iter().fold(String::new(), |acc, &word| acc + word + " ");
```

- `fold` is like reduce — it takes an initial value and accumulates from
there.
- Useful for calculating things like prefix sums, custom reductions, or
string concatenation.

------------------------------------------------------------------------

#### 🔍 **Finding Elements: `find()`, `position()`**

Efficient tools for searching without writing loops.

#### **Finding a Match**

```rust
let nums = vec![1, 2, 3];
if let Some(x) = nums.iter().find(|&&x| x > 1) {
println!("Found {}", x);
}
```

#### **Finding Index**

```rust
let idx = nums.iter().position(|&x| x == 2); // Some(1)
```

- `find()` gives you the first matching element.
- `position()` gives you the index instead.
- Use these when solving problems like:
- First unique character
- Search insert position (as a fast check before binary search)
- Finding the pivot or rotation point

------------------------------------------------------------------------

#### 📐 **Sliding Window with `.windows(n)`**

For overlapping subarrays of size `n`, `.windows()` is a clean and
efficient approach.

```rust
let v = vec![1, 2, 3, 4, 5];
for window in v.windows(3) {
println!("{:?} → sum = {}", window, window.iter().sum::<i32>());
}
```

- `.windows(n)` returns a `&[T]` slice — non-owning, no allocation.
- Perfect for problems like:
- Maximum sum of subarray of size `k`
- Subarray with k distinct elements
- Anagram sliding window search

⚠️ Remember: `.windows(n)` only works if `n <= vec.len()`, otherwise it
returns no elements.

------------------------------------------------------------------------

#### 🧱 **Partitioning with `.chunks(n)`**

Use `.chunks(n)` when you want **non-overlapping** groups of size `n`.

```rust
let data = vec![1, 2, 3, 4, 5];
for chunk in data.chunks(2) {
println!("{:?}", chunk);
}
```

**Output:**
[1, 2]
[3, 4]
[5]

- Common in problems involving:
- Grouped decoding/encoding (e.g. breaking into pairs or triplets)
- Transforming flat arrays into matrices or rows
- Parsing grid-based inputs

------------------------------------------------------------------------

#### ⚠️ **Common Pitfalls**

- Forgetting `.copied()` or `|&x|` when dealing with references in
`iter()`.
- Forgetting `.collect()` at the end of a transformation chain.
- Trying to `sort()` an iterator — sort on `Vec`, not `Iterator`.
- Using `chunks()` when you need `windows()` (overlapping vs
non-overlapping!).

------------------------------------------------------------------------

### **Bit-Fu in Rust: When You Absolutely, Definitely Need Bit Manipulation**

Bit manipulation isn’t the most common technique in LeetCode — but when
it shows up, **you can’t fake your way through it**. Problems like
finding the single number in an array, checking if a number is a power
of two, or manipulating subsets all rely on smart use of bits. Rust
gives you a powerful, expressive, and safe toolkit for bitwise
operations — but it’s low-level enough that **you need to know what
you're doing**.

This section covers the Rust bit manipulation features you’ll need to
breeze through those rare but critical problems.

------------------------------------------------------------------------

#### **Basic Bitwise Operators in Rust**

Rust gives you the standard set of bitwise operators — all operate on
integer types (`i32`, `u32`, `u64`, etc.):

| Operator | Symbol | Description                 |
|----------|--------|-----------------------------|
| AND      | `&`    | 1 if both bits are 1        |
| OR       | \|     | 1 if any bit is 1           |
| XOR      | `^`    | 1 if bits are different     |
| NOT      | `!`    | Flip all bits               |
| SHL      | `<<`   | Left shift (multiply by 2ⁿ) |
| SHR      | `>>`   | Right shift (divide by 2ⁿ)  |

```rust
let a = 0b1010; // 10
let b = 0b1100; // 12

let and = a & b; // 0b1000 = 8
let or  = a | b; // 0b1110 = 14
let xor = a ^ b; // 0b0110 = 6
let not = !a;    // Bitwise NOT (inverts every bit)
```

These work just like in C or Java — no surprises here.

------------------------------------------------------------------------

#### **Checking If a Number Is a Power of Two**

This classic trick shows up in problems like **Power of Two**,
**Counting Bits**, or anything involving subset masks.

```rust
fn is_power_of_two(n: i32) -> bool {
n > 0 && (n & (n - 1)) == 0
}
```

- The trick relies on the fact that powers of two have **exactly one bit
set**.
- `(n & (n - 1))` clears the lowest set bit — so if the result is zero,
only one bit was set.

------------------------------------------------------------------------

#### **Counting Set Bits (Hamming Weight)**

```rust
fn count_ones(mut n: u32) -> u32 {
let mut count = 0;
while n > 0 {
count += n & 1;
n >>= 1;
}
count
}
```

Or use the built-in:

```rust
let n: u32 = 13;
let ones = n.count_ones(); // 3
```

- Use `.count_ones()` for fast and clear solutions.
- You also have `.leading_zeros()`, `.trailing_zeros()`,
`.count_zeros()`, and `.swap_bytes()` for other tasks.

------------------------------------------------------------------------

#### **Finding the Lowest Set Bit**

```rust
let x = 0b10100;
let lowest_bit = x & (!x + 1); // Isolates the rightmost 1-bit
```

This technique is used in problems like **Sum of Two Integers**,
**Bitmask DP**, and **Fenwick Trees (Binary Indexed Tree)**.

------------------------------------------------------------------------

#### **Bitmasking for Subsets**

Many subset or combinatorics problems can be solved with bitmasks:

```rust
let nums = vec![1, 2, 3];
let n = nums.len();

for mask in 0..(1 << n) {
let mut subset = vec![];
for i in 0..n {
if (mask >> i) & 1 == 1 {
subset.push(nums[i]);
}
}
println!("{:?}", subset);
}
```

- Use `1 << i` to set the i-th bit.
- Loop through `0..(1 << n)` to iterate all subsets of a size-`n` array.
- This is perfect for:
- **Subsets**
- **Maximum AND/OR/XOR of Subsets**
- **Bitmask Dynamic Programming**

------------------------------------------------------------------------

#### **Toggle a Bit**

```rust
let mut flags = 0b1010;
flags ^= 1 << 1; // Toggles the second bit
```

- Bit toggling is used in some puzzle-style problems to track visited
states or flips.

------------------------------------------------------------------------

#### **Rust Traits and Methods That Help**

- `.count_ones()` → Count number of 1s
- `.count_zeros()` → Count number of 0s
- `.leading_zeros()` → Leading 0s from left (MSB side)
- `.trailing_zeros()` → Trailing 0s from right (LSB side)
- `.rotate_left(n)` / `.rotate_right(n)` → Useful in circular problems

------------------------------------------------------------------------

### **BinaryHeap in Rust: Practical Priority Queues Without the Panic**

Rust’s `BinaryHeap` is the standard way to implement a priority queue —
a data structure where elements are always retrieved in priority order.
It’s part of `std::collections`, and it gives you a fast, flexible tool
for working with dynamic, sorted data. The default behavior is a
**max-heap**, but Rust provides a clever way to use it as a
**min-heap**, too. Here's everything you need to know about using it
effectively in Rust.

------------------------------------------------------------------------

#### 📦 **Bring It In**

```rust
use std::collections::BinaryHeap;
```

Also add this if you plan to use it as a **min-heap**:

```rust
use std::cmp::Reverse;
```

------------------------------------------------------------------------

#### 🧱 **Creating a BinaryHeap**

**Empty Heap**

```rust
let mut heap = BinaryHeap::new();
```

**From a Vector**

```rust
let nums = vec![4, 1, 7, 3];
let heap: BinaryHeap<_> = nums.into_iter().collect();
```

- Collecting from an iterator builds the heap in O(n) time.

------------------------------------------------------------------------

#### ➕ **Adding Elements: `.push()`**

```rust
heap.push(10);
heap.push(3);
```

- Inserts the element in O(log n).
- Maintains heap property automatically.

------------------------------------------------------------------------

#### ➖ **Removing Elements: `.pop()`**

```rust
while let Some(top) = heap.pop() {
println!("{}", top);
}
```

- Pops the **greatest element** (max-heap) or smallest (min-heap with
`Reverse`).
- O(log n) per removal.

------------------------------------------------------------------------

#### 👁️ **Peeking at the Top Element: `.peek()`**

```rust
if let Some(&top) = heap.peek() {
println!("Top of heap: {}", top);
}
```

- Non-destructive. Returns a reference to the current highest-priority
element.
- Use it when you want to inspect the heap without modifying it.

------------------------------------------------------------------------

#### 🔻 **Using `Reverse` for Min-Heap**

Rust’s `BinaryHeap` is a **max-heap** by default. To simulate a
**min-heap**, wrap your elements in `Reverse`.

```rust
use std::cmp::Reverse;

let mut heap = BinaryHeap::new();
heap.push(Reverse(5));
heap.push(Reverse(2));
heap.push(Reverse(8));

if let Some(Reverse(val)) = heap.pop() {
println!("Smallest: {}", val);
}
```

- You wrap with `Reverse(value)` when inserting.
- You unwrap with `Reverse(x)` when popping or peeking.
- Works for any type that implements `Ord`.

------------------------------------------------------------------------

#### ⚙️ **Other Useful Methods**

| Method              | Description                                 |
|---------------------|---------------------------------------------|
| `push(val)`         | Insert a value into the heap (O(log n))     |
| `pop()`             | Remove and return the top value (O(log n))  |
| `peek()`            | Borrow the top value without popping (O(1)) |
| `len()`             | Get number of elements                      |
| `is_empty()`        | Check if the heap is empty                  |
| `clear()`           | Remove all elements                         |
| `into_sorted_vec()` | Converts to a sorted `Vec<T>`               |

```rust
let sorted: Vec<_> = heap.into_sorted_vec(); // Descending order
```

- Converts the heap into a sorted vector in O(n log n).
- Helpful when you want to flatten the heap after use.

------------------------------------------------------------------------

#### ⚠️ **Common Pitfalls**

- **It’s a max-heap by default** — don’t forget `Reverse()` if you need
min-heap behavior.
- **Custom types** must implement `Ord`, `PartialOrd`, `Eq`, and
`PartialEq` to be stored in the heap.
- **You need `mut`** to push or pop — don't forget to make your heap
mutable.

------------------------------------------------------------------------

### **Queues and Deques in Rust: Fast, Flexible, and Built Right In**

Many LeetCode problems — from **BFS traversals** to **sliding window
maximums** — rely on **queue** or **double-ended queue (deque)**
behavior. Rust’s standard library gives us a powerful and efficient tool
for both: `VecDeque`. It’s the right structure when you need **O(1)
insertion and removal from both ends**, which you can’t get from `Vec`
alone without performance penalties.

This section covers the core patterns and methods for using `VecDeque`
as a queue or deque in LeetCode-style problems.

------------------------------------------------------------------------

#### 📦 **Importing VecDeque**

```rust
use std::collections::VecDeque;
```

`VecDeque` lives in `std::collections`, just like `HashMap` and
`BinaryHeap`.

------------------------------------------------------------------------

#### 🚶‍♂️ **Using `VecDeque` as a Queue (FIFO)**

Queues follow **First-In, First-Out** behavior — used in BFS,
simulations, or level-order traversal.

```rust
let mut queue: VecDeque<i32> = VecDeque::new();

queue.push_back(1);           // enqueue
queue.push_back(2);
let front = queue.pop_front(); // dequeue (Some(1))
```

- `push_back()` adds to the **back**
- `pop_front()` removes from the **front**
- Both operations are **O(1)**

This is the go-to structure for **breadth-first search**, **task
scheduling**, and **level-order tree traversals**.

------------------------------------------------------------------------

#### 🔁 **Using `VecDeque` as a Deque (Double-Ended Queue)**

A **deque** supports pushing and popping at **both ends**.

```rust
let mut dq = VecDeque::new();

dq.push_front(10);
dq.push_back(20);
dq.push_front(5);       // [5, 10, 20]

let front = dq.pop_front(); // 5
let back = dq.pop_back();   // 20
```

- `push_front()` and `pop_back()` allow stack-like behavior from either
side.
- Very useful for **two-pointer techniques** or tracking **max/min in
windows**.

------------------------------------------------------------------------

#### 🌪️ **Deque-Based Sliding Window Maximum**

Problems like “Sliding Window Maximum” require maintaining a **monotonic
deque** to track potential candidates for the max.

Pattern:

```rust
let mut dq: VecDeque<usize> = VecDeque::new();
let nums = vec![1, 3, -1, -3, 5, 3, 6, 7];
let k = 3;
let mut result = vec![];

for i in 0..nums.len() {
// Remove indices outside the window
if let Some(&front) = dq.front() {
if front + k <= i {
dq.pop_front();
}
}
// Maintain descending order in deque
while let Some(&back) = dq.back() {
if nums[back] < nums[i] {
dq.pop_back();
} else {
break;
}
}
dq.push_back(i);
// Push result once window is full
if i + 1 >= k {
result.push(nums[*dq.front().unwrap()]);
}
}
```

- `VecDeque` allows us to efficiently remove both old values (from the
front) and dominated candidates (from the back).
- Total time complexity is **O(n)** due to amortized deque operations.

------------------------------------------------------------------------

#### 🧠 **Key Methods on `VecDeque`**

| Method            | Description                       |
|-------------------|-----------------------------------|
| `push_back(val)`  | Append to the end                 |
| `push_front(val)` | Insert at the front               |
| `pop_back()`      | Remove and return last element    |
| `pop_front()`     | Remove and return first element   |
| `front()`         | Borrow reference to first element |
| `back()`          | Borrow reference to last element  |
| `is_empty()`      | Check if the deque is empty       |
| `len()`           | Get number of elements            |
| `clear()`         | Remove all elements               |

------------------------------------------------------------------------

#### ⚠️ **Common Pitfalls**

- `VecDeque` is only useful when you need fast **push/pop at both ends**
— don’t use it like a `Vec` unless you need that.
- Avoid calling `.pop_front()` without checking `is_empty()` or using
`if let Some(...)` to handle `None`.
- Don’t forget `mut` on your `VecDeque` — all operations that modify it
require it.

------------------------------------------------------------------------

### **Graphs in Rust: Navigating Nodes the Idiomatic Way**

Graphs come up in many classic LeetCode problems — from pathfinding and
connectivity to topological sorts and cycle detection. While Rust
doesn't have a built-in graph type, it's **easy and efficient to build
your own** using `Vec<Vec<T>>` for adjacency lists.

This section focuses on **practical, interview-ready ways to represent
and traverse graphs** in Rust using only standard library tools.

------------------------------------------------------------------------

#### 🧱 **Graph Representation Using `Vec<Vec<T>>`**

The most common and flexible graph structure in Rust (and in LeetCode)
is an adjacency list:

```rust
let n = 5;
let mut graph: Vec<Vec<usize>> = vec![vec![]; n];
graph[0].push(1);
graph[1].push(2);
graph[2].push(3);
// and so on...
```

- Each `graph[u]` holds all neighbors of node `u`.
- Works for both **directed** and **undirected** graphs:
- For **undirected**, insert both `u → v` and `v → u`.
- Use `Vec<Vec<(usize, i32)>>` if you need edge weights.

------------------------------------------------------------------------

#### 🔍 **Depth-First Search (DFS)**

Rust’s ownership model makes recursive DFS very clean and safe.

```rust
fn dfs(u: usize, visited: &mut Vec<bool>, graph: &Vec<Vec<usize>>) {
if visited[u] {
return;
}
visited[u] = true;
for &v in &graph[u] {
dfs(v, visited, graph);
}
}
```

- Use a `visited` vector to track state.
- DFS is ideal for:
- **Cycle detection**
- **Connected components**
- **Topological sort (with post-order)**

------------------------------------------------------------------------

#### 🔁 **Breadth-First Search (BFS) Using `VecDeque`**

BFS requires a queue — and `VecDeque` is the perfect fit.

```rust
use std::collections::VecDeque;

fn bfs(start: usize, graph: &Vec<Vec<usize>>, visited: &mut Vec<bool>) {
let mut queue = VecDeque::new();
queue.push_back(start);
visited[start] = true;
while let Some(u) = queue.pop_front() {
for &v in &graph[u] {
if !visited[v] {
visited[v] = true;
queue.push_back(v);
}
}
}
}
```

- BFS is best for:
- **Shortest path in unweighted graphs**
- **Level-order traversal**
- **Bipartite graph checking**

------------------------------------------------------------------------

#### 📏 **Dijkstra’s Algorithm with `BinaryHeap`**

For weighted graphs, use a min-heap (via `BinaryHeap` + `Reverse`) to
track the next closest node.

```rust
use std::collections::BinaryHeap;
use std::cmp::Reverse;

fn dijkstra(start: usize, graph: &Vec<Vec<(usize, i32)>>, n: usize) -> Vec<i32> {
let mut dist = vec![i32::MAX; n];
dist[start] = 0;
let mut heap = BinaryHeap::new();
heap.push(Reverse((0, start))); // (distance, node)
while let Some(Reverse((d, u))) = heap.pop() {
if d > dist[u] {
continue;
}
for &(v, weight) in &graph[u] {
let new_dist = d + weight;
if new_dist < dist[v] {
dist[v] = new_dist;
heap.push(Reverse((new_dist, v)));
}
}
}
dist
}
```

- Use `Vec<Vec<(usize, i32)>>` for storing `(neighbor, weight)` edges.
- Dijkstra gives **shortest paths from one source** in weighted graphs
with non-negative edges.

------------------------------------------------------------------------

#### 🔗 **Union-Find (Disjoint Set Union, DSU)**

This structure is used in problems involving connected components, cycle
detection, and Kruskal’s MST algorithm.

```rust
struct DSU {
parent: Vec<usize>,
}

impl DSU {
fn new(n: usize) -> Self {
DSU { parent: (0..n).collect() }
}
fn find(&mut self, x: usize) -> usize {
if self.parent[x] != x {
self.parent[x] = self.find(self.parent[x]); // path compression
}
self.parent[x]
}
fn union(&mut self, x: usize, y: usize) -> bool {
let (xr, yr) = (self.find(x), self.find(y));
if xr == yr {
false
} else {
self.parent[xr] = yr;
true
}
}
}
```

- Very efficient: O(α(n)) per operation with path compression.
- Core structure for:
- **Graph connectivity**
- **Detecting cycles in undirected graphs**
- **MST (Minimum Spanning Tree)**

------------------------------------------------------------------------

### **Linked Lists in Rust: Owning the Pointer Game Safely**

Linked lists are everywhere on LeetCode — and while they’re
straightforward in many languages, **Rust makes you think carefully
about ownership, mutability, and recursion**. That’s a good thing: it
keeps you honest. But it also means you need to be prepared with the
right patterns to work with them efficiently in interviews.

This section walks through how to define, insert, reverse, and detect
cycles in singly linked lists — using idiomatic, interview-friendly
Rust.

------------------------------------------------------------------------

#### 🔧 **Defining a `ListNode` in Rust**

LeetCode’s Rust setup usually provides this for you, or expects you to
use it:

```rust
#[derive(PartialEq, Eq, Clone, Debug)]
pub struct ListNode {
pub val: i32,
pub next: Option<Box<ListNode>>,
}
```

- `Box<ListNode>` means the node owns its next node, on the heap.
- `Option<Box<...>>` means the end of the list is `None`.

You can define a helper constructor:

```rust
impl ListNode {
#[inline]
fn new(val: i32) -> Self {
ListNode { val, next: None }
}
}
```

This struct supports fully owned, mutable linked list construction and
traversal.

------------------------------------------------------------------------

#### ➕ **Inserting into a Linked List**

Manually building a list from a vector:

```rust
fn from_vec(values: Vec<i32>) -> Option<Box<ListNode>> {
let mut head: Option<Box<ListNode>> = None;
for &val in values.iter().rev() {
let mut node = Box::new(ListNode::new(val));
node.next = head;
head = Some(node);
}
head
}
```

- Build the list in reverse to avoid nested traversal.
- In-place insertion at the head is efficient and ownership-safe.

------------------------------------------------------------------------

#### 🔁 **Reversing a Linked List (Iteratively)**

One of the most common list tasks on LeetCode:

```rust
fn reverse_list(mut head: Option<Box<ListNode>>) -> Option<Box<ListNode>> {
let mut prev = None;
while let Some(mut node) = head.take() {
head = node.next.take();
node.next = prev;
prev = Some(node);
}
prev
}
```

- `take()` moves out of the `Option`, replacing it with `None`.
- This avoids borrowing issues and gives you full ownership to rearrange
the list.
- No recursion, no smart pointer gymnastics.

------------------------------------------------------------------------

#### 🌀 **Finding a Cycle (Floyd’s Tortoise and Hare)**

Use two pointers — fast and slow — to detect a cycle:

```rust
fn has_cycle(head: Option<Box<ListNode>>) -> bool {
let mut slow = head.as_ref();
let mut fast = head.as_ref();
while let (Some(s), Some(f)) = (slow, fast.and_then(|n| n.next.as_ref())) {
slow = s.next.as_ref();
fast = f.next.as_ref();
if std::ptr::eq(slow?, fast?) {
return true;
}
}
false
}
```

- You can’t use normal equality here — use `std::ptr::eq()` to compare
node addresses.
- `as_ref()` lets you traverse the list without taking ownership.
- `and_then()` safely follows `.next` inside an `Option`.

------------------------------------------------------------------------

#### ⚠️ **Rust Pitfalls to Avoid**

- You can’t mutate through a shared reference (`&`) — use `.take()` or
own the node via `mut Some(...)`.
- You can’t compare boxed nodes directly — use pointer equality
(`ptr::eq()`).
- You can’t freely clone or copy nodes — they’re heap-allocated and
non-`Copy`.

------------------------------------------------------------------------

### **Trees & Binary Trees in Rust: Strong Roots, Safe Branches**

Trees — especially binary trees — show up constantly in LeetCode:
traversals, depth calculations, symmetry checks, search trees, and
lowest common ancestors. Rust doesn’t have built-in support for trees,
but you can express them elegantly using `Option<Box<TreeNode>>`, just
like linked lists.

This section walks through how to define and work with binary trees in
Rust safely and idiomatically, covering all the major patterns you’ll
need to tackle LeetCode tree problems.

------------------------------------------------------------------------

#### 🌲 **Defining a `TreeNode` in Rust**

Most LeetCode problems involving binary trees will provide or expect
this structure:

```rust
#[derive(Debug, PartialEq, Eq)]
pub struct TreeNode {
pub val: i32,
pub left: Option<Box<TreeNode>>,
pub right: Option<Box<TreeNode>>,
}
```

And optionally:

```rust
impl TreeNode {
pub fn new(val: i32) -> Self {
TreeNode {
val,
left: None,
right: None,
}
}
}
```

- `Box` gives heap allocation and ownership.
- `Option<Box<...>>` is used for nullable child pointers (empty leaf
nodes).

------------------------------------------------------------------------

#### 🧭 **Depth-First Search: Preorder, Inorder, Postorder**

DFS is best expressed recursively in Rust.

**Preorder Traversal (Root → Left → Right)**

```rust
fn preorder(node: &Option<Box<TreeNode>>, output: &mut Vec<i32>) {
if let Some(n) = node {
output.push(n.val);
preorder(&n.left, output);
preorder(&n.right, output);
}
}
```

**Inorder Traversal (Left → Root → Right)**

```rust
fn inorder(node: &Option<Box<TreeNode>>, output: &mut Vec<i32>) {
if let Some(n) = node {
inorder(&n.left, output);
output.push(n.val);
inorder(&n.right, output);
}
}
```

**Postorder Traversal (Left → Right → Root)**

```rust
fn postorder(node: &Option<Box<TreeNode>>, output: &mut Vec<i32>) {
if let Some(n) = node {
postorder(&n.left, output);
postorder(&n.right, output);
output.push(n.val);
}
}
```

- Each traversal is clean, safe, and stack-safe unless the tree is very
deep.

------------------------------------------------------------------------

#### 🌊 **Breadth-First Search (Level-Order)**

Use `VecDeque` to implement level-order traversal:

```rust
use std::collections::VecDeque;

fn level_order(root: &Option<Box<TreeNode>>) -> Vec<i32> {
let mut output = vec![];
let mut queue = VecDeque::new();
if let Some(n) = root {
queue.push_back(n);
}
while let Some(node) = queue.pop_front() {
output.push(node.val);
if let Some(left) = &node.left {
queue.push_back(left);
}
if let Some(right) = &node.right {
queue.push_back(right);
}
}
output
}
```

- This traversal is perfect for **level-based problems**, such as
computing depth, checking completeness, or zigzag level traversal.

------------------------------------------------------------------------

#### 🔗 **Finding the Lowest Common Ancestor (LCA)**

Classic recursive pattern:

```rust
fn lowest_common_ancestor(
root: &Option<Box<TreeNode>>,
p: i32,
q: i32,
) -> Option<i32> {
fn helper(node: &Option<Box<TreeNode>>, p: i32, q: i32) -> Option<i32> {
if let Some(n) = node {
if n.val == p || n.val == q {
return Some(n.val);
}
let left = helper(&n.left, p, q);
let right = helper(&n.right, p, q);
if left.is_some() && right.is_some() {
return Some(n.val);
}
left.or(right)
} else {
None
}
}
helper(root, p, q)
}
```

- Works for binary trees (not necessarily BSTs).
- Traverse both sides; if both sides return non-`None`, current node is
LCA.

------------------------------------------------------------------------

#### 📏 **Balanced vs. Unbalanced Trees**

A binary tree is **balanced** if, for every node, the height difference
between the left and right subtrees is ≤ 1.

```rust
fn is_balanced(node: &Option<Box<TreeNode>>) -> bool {
fn height(n: &Option<Box<TreeNode>>) -> Option<i32> {
if let Some(node) = n {
let left = height(&node.left)?;
let right = height(&node.right)?;
if (left - right).abs() > 1 {
return None;
}
Some(1 + left.max(right))
} else {
Some(0)
}
}
height(node).is_some()
}
```

- Use `Option<i32>` to short-circuit if unbalanced.
- Recursive DFS solution is clean and avoids repeated height
calculations.

------------------------------------------------------------------------

#### 🌳 **Binary Search Tree (BST) Operations**

BSTs have a special property: **left < root < right**. You can use
this to optimize search and insert logic.

**Search a BST**

```rust
fn search_bst(node: &Option<Box<TreeNode>>, target: i32) -> bool {
match node {
Some(n) if n.val == target => true,
Some(n) if target < n.val => search_bst(&n.left, target),
Some(n) => search_bst(&n.right, target),
None => false,
}
}
```

**Insert into BST**

```rust
fn insert_bst(node: &mut Option<Box<TreeNode>>, val: i32) {
match node {
Some(n) => {
if val < n.val {
insert_bst(&mut n.left, val);
} else {
insert_bst(&mut n.right, val);
}
}
None => {
*node = Some(Box::new(TreeNode::new(val)));
}
}
}
```

- You’ll use mutable references to update the tree in-place.

------------------------------------------------------------------------

### You Made It. Now Go Break Things (Safely)
If you made it this far — congratulations. You’ve absorbed a
battle-tested toolbox of Rust patterns specifically designed for
LeetCode-style coding interviews. No fluff, no “intro to Rust” filler —
just the things you actually need when time is tight, the question is
tough, and the interviewer is watching. At this point, you should feel
confident working with `Vec`, `HashMap`, `BinaryHeap`, recursion, and
even linked lists without panicking. You’ve seen how to structure your
code safely, mutate data intentionally, and write logic that is both
expressive and correct. Most people won’t dare use Rust in an interview
— and that’s exactly why you’re going to stand out. If you’re fast and
fluent with the tools in this guide, Rust becomes a strength, not a
liability. Keep your solutions clean, readable, and idiomatic — no
unsafe shortcuts, no ownership drama. Take a deep breath, trust your
prep, and go in knowing that you're playing the coding game on **hard
mode** — and winning anyway. Good luck out there, Rustacean.
