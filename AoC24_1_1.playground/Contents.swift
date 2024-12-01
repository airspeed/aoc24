import UIKit
import Foundation

let input = """
<redacted>
"""
let lines =
input.split(separator: "\n")
    .map({ $0.split(separator: " ")
    .compactMap({ Int($0) }) })
let firstList =
lines.compactMap(\.first).sorted()
let secondList =
lines.compactMap(\.last).sorted()
let differences =
zip(firstList, secondList).map({ abs($0.0 - $0.1) })
let result1 =
differences.reduce(0, +)
let similarity =
firstList.map { score in
    score * secondList.filter { $0 == score }.count
}
let result2 =
similarity.reduce(0, +)
print(result1)
print(result2)
