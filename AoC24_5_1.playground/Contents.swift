import Foundation

let input = """
<redacted>
"""
let lines =
input.split(separator: "\n")

// MARK: Page Ordering

let pageOrderingRegex = Regex(/(\d{1,3})\|(\d{1,3})/)
let pageOrderings = Set(
    lines.compactMap { line -> PageOrdering? in
        let output = try? pageOrderingRegex.wholeMatch(in: line)?.output
        guard let output else {
            return nil
        }
        assert(output.count == 3)
        guard let before: Substring = output[1].substring,
              let after: Substring = output[2].substring else {
            return nil
        }
        let before1: String = String(before)
        let after1: String = String(after)
        guard let before2: Int = Int(before1),
              let after2: Int = Int(after1) else {
            return nil
        }
        return PageOrdering(before: before2, after: after2)
    }
)

let updateRegex = Regex(/(\d{1,3},?)+/)
let updates =
lines.compactMap { line -> [Int]? in
    let output = try? updateRegex.wholeMatch(in: line)?.output
    guard let output else {
        return nil
    }
    assert(output.count > 1)
    guard let pages: Substring = output.first?.substring else {
        return nil
    }
    return pages
        .split(separator: ",")
        .map(String.init)
        .compactMap(Int.init)
}

let result =
updates.filter { series in
    series.reduce(([Int](), true)) { acc, next in
        guard !acc.0.isEmpty else {
            return ([next], true)
        }
        guard acc.1 else {
            return (acc.0, false)
        }
        let previousPages = acc.0
        return (
            previousPages + [next],
            pageOrderings.filter { ordering in
                ordering.before == next
                && previousPages.contains(ordering.after)
            }.isEmpty
        )
    }.1
}
let median =
result
    .map { series -> Int in
        series[series.count / 2]
    }
let answer =
median
    .reduce(0, +)
print(answer)

struct PageOrdering: Hashable {
    let before: Int
    let after: Int
}
extension PageOrdering: CustomStringConvertible {
    var description: String {
        "\(before)|\(after)"
    }
}
