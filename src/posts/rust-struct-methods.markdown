---
title: Rust Struct Method Coolness
category: Rust
---

I learnt something awesome from a mentor when completing some exercsies on the excellent [exercism.io](https://exercism.io).

Basically if you have a struct in rust (like a string) and you want to call a method on that struct, you would do so like this:

```Rust
let string = "hello world";
string.len() // 11
```

However, seeing as when defining a method on a struct, the first argument is always just a reference to `self`, we can also do the following:

```Rust
let string = "hello world";
str::len(string) // 11
```

Why would you want to do this you may ask? Easy, **Iterators**:

```Rust
let vector = vec!["hello", "world"];
vector.iter().map(|s| s.len()).collect::<Vec<_>>()
vector.into_iter().map(str::len).collect::<Vec<_>>() // much nicer

# (into_iter is required here to get the types right)
```

### Pretty cool hey?
