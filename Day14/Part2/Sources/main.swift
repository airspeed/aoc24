// The Swift Programming Language
// https://docs.swift.org/swift-book

import Foundation

let now = Date()

let input = """
<redacted>
"""
let lines = input.split(separator: "\n")
let spaceW = 101
let spaceH = 103
let spaceMX = spaceW / 2
let spaceMY = spaceH / 2
if #available(macOS 15.2, *) {
    let robotRegex = Regex(/p=(-?\d{1,3}),(-?\d{1,3}) v=(-?\d{1,3}),(-?\d{1,3})/)
    let robots = lines.reduce([Robot]()) { acc, next in
        if let output = try? robotRegex.wholeMatch(in: next)?.output,
            let s1 = output[1].substring,
            let s2 = output[2].substring,
            let s3 = output[3].substring,
            let s4 = output[4].substring,
            let px = Int(s1),
            let py = Int(s2),
            let vx = Int(s3),
            let vy = Int(s4) {
            return acc + [Robot(p: Point(x: px, y: py), v: Point(x: vx, y: vy))]
        } else {
            assertionFailure()
            return acc
        }
    }
    var allPositions = Set<Set<Point>>()
    let positions =
    (0...10500).map { s -> (Set<Point>, Int) in
        (
            Set(
                robots
                    .map { $0.posAt(second: s) }            
            ),
            s
        )
    }
    // print(positions)
    let repetitionIndex = positions.first { s, i in
        !allPositions.insert(s).inserted
    }?.1 ?? -1
    print(repetitionIndex)
    var minDensity: Decimal = .maximum
    let scores: [(Decimal, Int)] =
    (0...repetitionIndex).map { s -> (Decimal, Int) in
        let density: Decimal =
            robots
                .map { $0.posAt(second: s) }
                .calculateDensityScore(),
        let step =
        (
            density,
            s
        )
        if density < minDensity {
            minDensity = density
            print(density)
            print(s)
        }
        return step
    }
    print(scores.min(by: { $0.0 < $1.0 }))
}

// MARK: Point
struct Point: Hashable {
    let x: Int
    let y: Int
}
extension Point: CustomStringConvertible {
    var description: String {
        "(\(x), \(y))"
    }
    func distance(from other: Self) -> Decimal {
        pow(Decimal(x - other.x), 2) + pow(Decimal(y - other.y), 2)
    }
}
extension Array where Element == Point {
    var q1: Self {
        filter { $0.x < spaceMX && $0.y < spaceMY }
    }
    var q2: Self {
        filter { $0.x > spaceMX && $0.y < spaceMY }
    }
    var q3: Self {
        filter { $0.x < spaceMX && $0.y > spaceMY }
    }
    var q4: Self {
        filter { $0.x > spaceMX && $0.y > spaceMY }
    }
    func calculateDensityScore() -> Decimal {
        reduce([Decimal]()) { acc, next -> [Decimal] in
            acc + flatMap { p -> Decimal in
                next.distance(from: p)
            }
        }
        .reduce(0, +)
    }
}
// MARK: Robot
struct Robot: Hashable {
    let p: Point
    let v: Point
}
extension Robot: CustomStringConvertible {
    var description: String {
        "p\(p)*v\(v)"
    }
}
extension Robot {
    func posAt100s() -> Point {
        let xAt100 = p.x + v.x * 100
        let yAt100 = p.y + v.y * 100
        let teleportedX = xAt100 % spaceW
        let teleportedY = yAt100 % spaceH
        let normalizedX = teleportedX < 0 ? teleportedX + spaceW : teleportedX
        let normalizedy = teleportedY < 0 ? teleportedY + spaceH : teleportedY
        return Point(x: normalizedX, y: normalizedy)
    }
    func posAt(second: Int) -> Point {
        let xAtSecond = p.x + v.x * second
        let yAtSecond = p.y + v.y * second
        let teleportedX = xAtSecond % spaceW
        let teleportedY = yAtSecond % spaceH
        let normalizedX = teleportedX < 0 ? teleportedX + spaceW : teleportedX
        let normalizedy = teleportedY < 0 ? teleportedY + spaceH : teleportedY
        return Point(x: normalizedX, y: normalizedy)
    }
}
print(Date().timeIntervalSince(now))