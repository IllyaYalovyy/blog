use demo_post::example;

#[test]
fn example_returns_answer() {
    pretty_assertions::assert_eq!(example(), 42);
}
