import Foundation

public func performPart1(
    rows: [Substring]
) -> Int {
    let cityMap: [Point: Character] = Dictionary(
        uniqueKeysWithValues:
            rows
            .enumerated()
            .flatMap({ offsetY, row -> [(Point, Character)] in
                row.enumerated().map { offsetX, char -> (Point, Character) in
                    (Point(x: offsetX, y: offsetY), char)
                }
            })
    )
    let mapWidth: Int = cityMap.keys.map(\.x).max() ?? 0
    let mapHeight: Int = cityMap.keys.map(\.y).max() ?? 0

    let antennas: [Character : [(key: Point, value: Character)]] =
    Dictionary(grouping: cityMap, by: \.value)
        .filter { $0.key != .neutral && $0.key != .antinode }
    let antennasCouples: [Character : Set<AntennasCouple>] =
    antennas.mapValues { values -> Set<AntennasCouple> in
        values.reduce(Set<AntennasCouple>()) { acc, next in
            if acc.isEmpty {
                [AntennasCouple(a: next.key, b: next.key)]
            } else {
                acc.inserting(
                    acc.flatMap { couple in
                        [
                            AntennasCouple(a: couple.a, b: next.key),
                            AntennasCouple(a: couple.b, b: next.key)
                        ]
                    }
                )
            }
        }
    }
    .mapValues { value in
        value.filter { !$0.isIdentity }
    }
    let antennasMitRange = antennasCouples
        .mapValues { value in
            value.map { couple in
                AntennasCouplesRange(
                    couple: couple,
                    range: calculateRange(for: couple, width: mapWidth, height: mapHeight)
                )
            }
        }
    print(antennasMitRange)
    let antennasWithAntinodes =
    antennasMitRange
        .reduce(Set<Point>()) { acc, next in
            let (_, value) = next
            let antinodes = value.flatMap { coupleWithRange in
                coupleWithRange.antinodes
            }
            return acc.union(antinodes)
        }
    print(antennasWithAntinodes.count)
    print(antennasWithAntinodes.map { point in
        cityMap.filter { $0.key == point }
    })
    return antennasWithAntinodes.count
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
        [w, e, n, s]
    }
    func isAdjacent(to other: Self) -> Bool {
        neighbours.contains(other)
    }
//    var isOutOfMap: Bool {
//        x < 0 || y < 0 || x > mapWidth || y > mapHeight
//    }
}
extension Set {
    func inserting(_ element: Element) -> Self {
        var new = self
        new.insert(element)
        return new
    }
    func inserting(_ elements: [Element]) -> Self {
        union(elements)
    }
}
extension Character {
    static var neutral: Character { "." }
    static var antinode: Character { "#" }
}
struct AntennasCouple: Hashable, CustomStringConvertible {
    let a: Point
    let b: Point
    
    // probably not needed given how couples are generated
    static func == (lhs: AntennasCouple, rhs: AntennasCouple) -> Bool {
        switch (lhs.a, lhs.b, rhs.a, rhs.b) {
        case (let a, let b, let c, let d) where a == c && b == d: true
        case (let a, let b, let c, let d) where a == d && b == c: true
        case _: false
        }
    }
    
    var isIdentity: Bool {
        a == b
    }
    
    var description: String {
        "(\(a), \(b))"
    }
}
struct AntennasCouplesRange: Hashable, CustomStringConvertible {
    let couple: AntennasCouple
    let range: Set<Point>
    
    var description: String {
        "\(couple): \(range)"
    }
    
    var antinodes: Set<Point> {
        range
            .filter {
                $0 != couple.a && $0 != couple.b
            }
            .filter { point in
            let distanceA = calculateDistance(p1: couple.a, p2: point)
            let distanceB = calculateDistance(p1: couple.b, p2: point)
            return
                (
                    distanceA.0 == 2 * distanceB.0
                    && distanceA.1 == 2 * distanceB.1
                )
                ||
                (
                    distanceB.0 == 2 * distanceA.0
                    && distanceB.1 == 2 * distanceA.1
                )
        }
    }
}

func calculateRange(for couple: AntennasCouple, width: Int, height: Int) -> Set<Point> {
    var result = Set<Point>()
    for point in AntennasRange(couple: couple, width: width, height: height) {
        result.insert(point)
    }
    return result
}
func calculateDistance(p1: Point, p2: Point) -> (Int, Int) {
    let dx = abs(p1.x - p2.x)
    let dy = abs(p1.y - p2.y)
    return (dx, dy)
}

struct AntennasRangeIterator: IteratorProtocol {
    let couple: AntennasCouple
    let dx: Int
    let dy: Int
    let width: Int
    let height: Int
    var lastPoint: Point?
    init(couple: AntennasCouple, width: Int, height: Int) {
        self.couple = couple
        let (a, b) = (couple.a, couple.b)
        let tentativeDx = a.x - b.x
        let tentativeDy = a.y - b.y
        switch (tentativeDx, tentativeDy) {
        case (0, _), (_, 0):
            self.dx = abs(tentativeDx)
            self.dy = abs(tentativeDy)
        case (let ddx, let ddy) where (ddx < 0) == (ddy < 0):
            self.dx = abs(tentativeDx)
            self.dy = abs(tentativeDy)
        case (let ddx, let ddy) where ddx < 0 && ddy > 0:
            self.dx = -tentativeDx
            self.dy = -tentativeDy
        case (let ddx, let ddy) where ddx > 0 && ddy < 0:
            self.dx = tentativeDx
            self.dy = tentativeDy
        case _:
            self.dx = 0
            self.dy = 0
            assertionFailure("Invalid couple")
        }
        self.width = width
        self.height = height
    }
    mutating func next() -> Point? {
        if let lastPoint {
            let newTentativePoint = Point(x: lastPoint.x + dx, y: lastPoint.y + dy)
            if newTentativePoint.x > width || newTentativePoint.y > height
            || newTentativePoint.x < 0 || newTentativePoint.y < 0 {
                return nil
            } else {
                self.lastPoint = newTentativePoint
                return newTentativePoint
            }
        } else {
            let newInitialPoint =
            couple.a.closerToZero(dx: dx, dy: dy, width: width, height: height)
            self.lastPoint = newInitialPoint
            return newInitialPoint
        }
    }
}

extension Point {
    func closerToZero(dx: Int, dy: Int, width: Int, height: Int) -> Point? {
        let newTentativePoint: Point =
        Point(x: x - dx, y: y - dy)
        if newTentativePoint.x < 0 || newTentativePoint.y < 0 || newTentativePoint.x > width || newTentativePoint.y > height {
            return self
        } else {
            return newTentativePoint.closerToZero(dx: dx, dy: dy, width: width, height: height)
        }
    }
}
struct AntennasRange: Sequence {
    let couple: AntennasCouple
    let width: Int
    let height: Int
    func makeIterator() -> AntennasRangeIterator {
        AntennasRangeIterator(
            couple: couple,
            width: width,
            height: height
        )
    }
}
