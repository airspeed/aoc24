import Foundation

let now = Date()
let input = """
<redacted>
"""
let input2 = """
RRRRIICCFF
RRRRIICCCF
VVRRRCCFFF
VVRCCCJFFF
VVVVCJJCFE
VVIVCCJJEE
VVIIICJJEE
MIIIIIJJEE
MIIISIJEEE
MMMISSJEEE
"""
let input3 = """
OOOOO
OXOXO
OOOOO
OXOXO
OOOOO
"""
let input4 = """
AAAA
BBCD
BBCC
EEEC
"""
let input5 = """
EEEEE
EXXXX
EEEEE
EXXXX
EEEEE
"""
let input6 = """
AAAAAA
AAABBA
AAABBA
ABBAAA
ABBAAA
AAAAAA
"""
let rows = input
    .split(separator: "\n")
let groundMap: [Point: String] = Dictionary(
    uniqueKeysWithValues:
        rows
        .enumerated()
        .flatMap({ offsetY, row -> [(Point, String)] in
            row.enumerated().map { offsetX, char -> (Point, String) in
                (Point(x: offsetX, y: offsetY), "\(char)")
            }
        })
)
let mapWidth = groundMap.keys.map(\.x).max() ?? 0
let mapHeight = groundMap.keys.map(\.y).max() ?? 0

func compute(regions: [Int: (String, Set<Point>)] = [:], visited: Set<Point> = []) -> [Int: (String, Set<Point>)] {
    guard let nextKey: Point = groundMap.first(where: { key, value in
        !visited.contains(key)
    })?.key, let nextValue: String = groundMap[nextKey] else {
        return regions
    }
    let nextSet = area(startingAt: (nextKey, nextValue), visited: [])
    let nextVisited = visited.union(nextSet)
    return compute(
        regions: regions.merging([regions.count: (nextValue, nextSet)]) { $1 },
        visited: nextVisited
    )
}

// MARK: Solution

let regions: [Int: (String, Set<Point>)] = compute()
let regionsWithAreasAndPerimeters: [(String, Int, Int)] =
regions.map { _, value -> (String, Int, Int) in
    let (char, points) = value
    return (
        char,
        points.count,
        perimeter(points: points, targetChar: char)
    )
}
print(regionsWithAreasAndPerimeters.sorted(by: { lhs, rhs in lhs.0 < rhs.0 }))
let regionsWithPrices: [(String, Int)] =
regionsWithAreasAndPerimeters.map { plant, area, perimeter in
    (plant, area * perimeter)
}
let solution: Int =
regionsWithPrices.map(\.1)
.reduce(0, +)
print(solution)

print(Date().timeIntervalSince(now))

func area(
    startingAt element: (key: Point, value: String),
    visited: Set<Point>,
    pipe: Set<Point> = []
) -> Set<Point> {
    let relevantNeighbours = element.key.neighbours.filter({ p in
        !visited.contains(p) && groundMap[p] == element.value
    })
    if let next = relevantNeighbours.first {
        return area(
            startingAt: (key: next, value: element.value),
            visited: visited.inserting(element.key),
            pipe: pipe.union(relevantNeighbours.filter { $0 != next })
        ).inserting(element.key)
    } else if let next = pipe.first {
        return area(
            startingAt: (key: next, value: element.value),
            visited: visited.inserting(element.key),
            pipe: pipe.filter { $0 != next }
        ).inserting(element.key)
    } else {
        return visited.inserting(element.key)
    }
}

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
        Set([w, e, n, s]).filter { !$0.isOutOfMap }
    }
    func isAdjacent(to other: Self) -> Bool {
        neighbours.contains(other)
    }
    var isOutOfMap: Bool {
        x < 0 || y < 0 || x > mapWidth || y > mapHeight
    }
}
extension Point: Comparable {
    static func <(lhs: Self, rhs: Self) -> Bool {
        switch (lhs.x, rhs.x, lhs.y, rhs.y) {
            case (let x1, let x2, _, _) where x1 < x2: true
            case (let x1, let x2, _, _) where x1 > x2: false
            case (_, _, let y1, let y2): y1 <= y2
        }
    }
}
extension Set {
    func inserting(_ element: Element) -> Self {
        var new = self
        new.insert(element)
        return new
    }
}

func perimeter(points: Set<Point>, targetChar: String) -> Int {
    let nxs =
    points.filter {
        groundMap[$0.n] != groundMap[$0]
    }
    let sxs =
    points.filter {
        groundMap[$0.s] != groundMap[$0]
    }
    let wxs =
    points.filter {
        groundMap[$0.w] != groundMap[$0]
    }
    let exs =
    points.filter {
        groundMap[$0.e] != groundMap[$0]
    }
    let nxsCount: Int =
    horizontalPerimeter(points: nxs, targetChar: targetChar, orientation: .n)
    let sxsCount: Int =
    horizontalPerimeter(points: sxs, targetChar: targetChar, orientation: .s)
    let wxsCount: Int =
    verticalPerimeter(points: wxs, targetChar: targetChar, orientation: .w)
    let exsCount: Int =
    verticalPerimeter(points: exs, targetChar: targetChar, orientation: .e)
    return nxsCount + sxsCount + wxsCount + exsCount
}

func horizontalPerimeter(points: Set<Point>, targetChar: String, orientation: Himmelsrichtung) -> Int {
    Set(points.map(\.y)).map { y -> Int in
        points.filter { $0.y == y }.reduce(0) { acc, next in
            if groundMap[next.e] != targetChar || groundMap[orientation == .n ? next.e.n : next.e.s] == targetChar {
                acc + 1
            } else {
                acc
            }
        }
    }
    .reduce(0, +)
}
func verticalPerimeter(points: Set<Point>, targetChar: String, orientation: Himmelsrichtung) -> Int {
    Set(points.map(\.x)).map { x -> Int in
        points.filter { $0.x == x }.reduce(0) { acc, next in
            if groundMap[next.s] != targetChar || groundMap[orientation == .w ? next.s.w : next.s.e] == targetChar {
                acc + 1
            } else {
                acc
            }
        }
    }
    .reduce(0, +)
}
enum Himmelsrichtung: Equatable {
    case n
    case e
    case s
    case w
}