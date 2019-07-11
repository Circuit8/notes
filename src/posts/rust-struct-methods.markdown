---
title: Rust Struct Methods -> Cool stuff
category: Rust
---

Yes.

This would be similar to the two calls to len() in the following:

```Rust
let s = "hello world";
println!("method: {}", s.len());
println!("function: {}", str::len(s));
```

Sometimes the latter would be useful to use to pass to a map function, but the former is more clear in most other cases.

```Rust
let v = vec!["hello", "world"];
let lens1 = v.iter().map(|s| s.len()).collect::<Vec<_>>();
let lens2 = v.into_iter().map(str::len).collect::<Vec<_>>();

println!("{:?} {:?}", lens1, lens2);
```

> Note: that the lens2 uses an into_iter(), so v no longer owns the Vec. An alternative is to use iter().cloned() otherwise the types won't be right.
