import Foundation

let input = """
<redacted>
"""
let instructionRegex = Regex(/mul\([\d]{1,3},[\d]{1,3}\)|don't\(\)|do\(\)/)
let matches =
input.matches(of: instructionRegex)
let ranges =
matches.map({ match in
    input[match.range]
})
let filteredRanges =
activeRanges(from: ranges)

let operands =
listOperands(from: filteredRanges)
let result =
zip(operands.compactMap(\.first), operands.compactMap(\.last))
    .map(*)
    .reduce(0, +)
print(result)

func listOperands(from ranges: [Substring]) -> [[Int]] {
    ranges.map({ substring in
        let operandRegex = Regex(/(\d){1,3}/)
        let operands = substring.matches(of: operandRegex)
        assert(operands.count == 2)
        return operands.compactMap { match in
            Int(substring[match.range])
        }
    })
}
func activeRanges(from ranges: [Substring]) -> [Substring] {
    ranges.reduce(([Substring](), true)) { acc, next in
        switch (next, acc.1) {
        case (.do_, _): (acc.0, true) // enable
        case (.dont_, _): (acc.0, false) // disable
        case (_, false): acc // skip
        case _: (acc.0 + [next], acc.1) // append
        }
    }.0
}

extension String {
    static var dont_: String { "don't()" }
    static var do_: String { "do()" }
}
