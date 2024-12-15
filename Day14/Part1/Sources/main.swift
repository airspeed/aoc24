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
    let posAt100s =
    robots
        .map { $0.posAt100s() }
    let quadrants =
    posAt100s.q1.count * posAt100s.q2.count * posAt100s.q3.count * posAt100s.q4.count
    print(quadrants)
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
}
print(Date().timeIntervalSince(now))