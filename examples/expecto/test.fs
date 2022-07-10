module Tests

open Expecto

[<Tests>]
let tests =
    testList "SomeTests" [ test "Equals" { Expect.equal 1 1 "Was not equal" } ]
