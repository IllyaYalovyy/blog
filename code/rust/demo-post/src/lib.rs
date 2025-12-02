//! Demo library for the accompanying article.

/// Returns the answer to life, the universe, and everything.
pub fn example() -> i32 {
    42
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn example_returns_answer() {
        assert_eq!(example(), 42);
    }
}
