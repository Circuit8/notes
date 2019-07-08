---
title: Rust Unit Tests
---

The following code sets up unit testing in a file

```Rust
#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn test_add() {
        assert_eq!(add(1, 2), 3);
    }
}
```

There are a few important bits here:

- `#[cfg()]` is a macro which conditionally compiles the code that follows it if being run in the given environment, so calling `#[cfg(test)]` only compiles the tests module when running tests, Sweet.
- `use super::*` imports the parent namespace so we can access the functions for our file in our tests
- `#[test]` lets rust know that the following function is actually a test.

Run `cargo test` and were good to go!
