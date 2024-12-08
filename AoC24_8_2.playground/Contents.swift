import Foundation

let now = Date()

let input = """
<redacted>
"""
let rows =
input.split(separator: "\n")

let solution =
performPart2(rows: rows)

print(solution)
print(Date().timeIntervalSince(now))

