import Foundation

let now = Date()

let input = """
<redacted>
"""
let lines =
input.split(separator: "\n")

let now2 = Date()

let solution3 = performPart2(lines: lines) // most performant
print(solution3)
print(Date().timeIntervalSince(now2))
