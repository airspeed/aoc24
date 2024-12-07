import Foundation

let now = Date()

let input = """
<redacted>
"""
let lines =
input.split(separator: "\n")

let solution1 = performPart1(lines: lines)
print(Date().timeIntervalSince(now))
let now1 = Date()
let solution2 = performPart2(lines: lines.filter { (line: Substring) -> Bool in
    !solution1.contains(where: { sol1 in
        line.prefix("\(sol1)".count) == "\(sol1)"
    })
})
print(solution2)
print(Date().timeIntervalSince(now1))

let now2 = Date()

let solution3 = performPart2(lines: lines) // most performant
print(solution3)
print(Date().timeIntervalSince(now2))
