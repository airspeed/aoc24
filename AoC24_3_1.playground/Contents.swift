import Foundation

let input = """
<redacted>
"""
let instructionRegex = Regex(/mul\(([\d]{1,3}),([\d]{1,3})\)/)
let matches =
input.matches(of: instructionRegex)
let ranges =
matches.map({ match in
    input[match.range]
})
let operands =
ranges.map({ substring in
    let operandRegex = Regex(/(\d){1,3}/)
    let operands = substring.matches(of: operandRegex)
    assert(operands.count == 2)
    return operands.compactMap { match in
        Int(substring[match.range])
    }
})
let result =
zip(operands.compactMap(\.first), operands.compactMap(\.last))
    .map(*)
    .reduce(0, +)
print(result)
