import Foundation

let input = """
<redacted>
"""
let lines =
input.split(separator: "\n")
    .map({ $0.split(separator: " ")
        .compactMap({ Int($0) }) })
let safe =
lines
    .filter { report in
        report.isSafe() || report.reversed().isSafe()
    }
let result1 =
safe.count
print(result1)

struct Report: Equatable {
    let element: Int?
    let ordering: ComparisonResult?
    let unsafeCount: Int
    
    static var epsilon: Self {
        .init(element: nil, ordering: nil, unsafeCount: 0)
    }
    
    var isSafe: Bool {
        unsafeCount < 2 // part1: 1
    }
}

extension Int {
    func comparing(_ other: Self) -> ComparisonResult {
        if self > other {
            .orderedDescending
        } else {
            if self < other {
                .orderedAscending
            } else {
                .orderedSame
            }
        }
    }
}

extension Array where Element == Int {
    func isSafe() -> Bool {
        reduce(Report.epsilon) { acc, next in
            guard let lastElement = acc.element else { // first element
                return Report(element: next, ordering: nil, unsafeCount: acc.unsafeCount)
            }
            guard abs(lastElement - next) > 0 && abs(lastElement - next) < 4 else {
                return Report(element: lastElement, ordering: acc.ordering, unsafeCount: acc.unsafeCount + 1)
            }
            guard let lastOrdering = acc.ordering else { // second valid element
                return Report(
                    element: next, ordering: lastElement.comparing(next), unsafeCount: acc.unsafeCount
                )
            }
            guard lastOrdering == lastElement.comparing(next) else {
                return Report(element: lastElement, ordering: lastOrdering, unsafeCount: acc.unsafeCount + 1)
            }
            return Report(
                element: next, ordering: lastElement.comparing(next), unsafeCount: acc.unsafeCount
            )
        }.isSafe
    }
}
