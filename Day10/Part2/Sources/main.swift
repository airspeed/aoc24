// The Swift Programming Language
// https://docs.swift.org/swift-book

import Foundation
let input = """
<redacted>
"""

let now = Date()
let rows = input
    .split(separator: "\n")
var start: Character { "0" }
extension Set {
    func inserting(_ element: Element) -> Self {
        var new = self
        new.insert(element)
        return new
    }
}
let labMap: [Point : Int] = Dictionary(
    uniqueKeysWithValues:
        rows
        .enumerated()
        .flatMap({ offsetY, row -> [(Point, Int)] in
            row.enumerated().compactMap { offsetX, char -> (Point, Int)? in
                if let charInt: Int = Int("\(char)") {
                    (Point(x: offsetX, y: offsetY), charInt)
                } else {
                    nil
                }
            }
        })
)
let mapWidth = labMap.keys.map(\.x).max() ?? 0
let mapHeight = labMap.keys.map(\.y).max() ?? 0
// print(labMap)

let neuner =
labMap.filter { key, value in
    value == 9
}
let score =
neuner.flatMap {
    $0.key.navigateTrail()
}
print(score.count)
print(Date().timeIntervalSince(now))

struct Point: Hashable {
    let x: Int
    let y: Int
}
extension Point: CustomStringConvertible {
    var description: String {
        "(\(x),\(y))"
    }
}
extension Point {
    var w: Self {
        Point(x: x - 1, y: y)
    }
    var e: Self {
        Point(x: x + 1, y: y)
    }
    var n: Self {
        Point(x: x, y: y - 1)
    }
    var s: Self {
        Point(x: x, y: y + 1)
    }
    var nw: Self {
        Point(x: x - 1, y: y - 1)
    }
    var ne: Self {
        Point(x: x + 1, y: y - 1)
    }
    var sw: Self {
        Point(x: x - 1, y: y + 1)
    }
    var se: Self {
        Point(x: x + 1, y: y + 1)
    }
    var neighbours: Set<Self> {
        [w, e, n, s]
    }
    func isAdjacent(to other: Self) -> Bool {
        neighbours.contains(other)
    }
    var isOutOfMap: Bool {
        x < 0 || y < 0 || x > mapWidth || y > mapHeight
    }
}

extension Point {
    func navigateTrail() -> [[Point]] {
        if labMap[self] == 0 {
            return [[self]]
        } else {
            let trailNeighbours: [Point] =
            neighbours
            .filter { point in
                if let p1 = labMap[point], let p2 = labMap[self] {
                    p1 == p2 - 1
                } else {
                    false
                }
            }
            return trailNeighbours.flatMap { (tn: Point) -> [[Point]] in
                let restTrail: [[Point]] = tn.navigateTrail() // [[0]]
                let result: [[Point]] = restTrail
                .map { (trail: [Point]) -> [Point] in
                    [self] + trail
                }  // [[1, 0]]
                return result
            }
        }
    }
}
