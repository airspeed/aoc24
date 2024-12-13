// The Swift Programming Language
// https://docs.swift.org/swift-book


import Foundation

let now = Date()
let input = """
20 82084 1650 3 346355 363 7975858 0
"""

let inputSlice: [Substring] =
input.split(separator: " ")
var stones =
[Int: Int]()
var splits =
[Int: [Int]]()

for stone in inputSlice.compactMap({ Int($0) }) {
    stones[stone] = 1
}
for _ in (0..<75) {
    stones = blink(stones: stones)
}
print(stones.values.reduce(0, +))

@MainActor
func blink(stones: [Int: Int]) -> [Int: Int] {
    var nextStones = [Int: Int]()

    for (key, value) in stones {
        if key == 0 {
            let newVal = nextStones[1] ?? 0
            nextStones[1] = newVal + value
        } else if let cache = splits[key] {
            let newKeyLeft = cache.first!
            let newValLeft = nextStones[newKeyLeft] ?? 0
            nextStones[newKeyLeft] = newValLeft + value
            let newKeyRight = cache.last!
            let newValRight = nextStones[newKeyRight] ?? 0
            nextStones[newKeyRight] = newValRight + value
        } else if key.numberOfChars() % 2 == 0 {
            let numberOfChars = key.numberOfChars()
            let d: Int = Int(pow(Float(10), Float(numberOfChars / 2)))
            let left = key / d
            let right = key % d
            let newValLeft = nextStones[left] ?? 0
            nextStones[left] = newValLeft + value
            let newValRight = nextStones[right] ?? 0
            nextStones[right] = newValRight + value
            splits[key] = [left, right]
        } else {
            let newVal = nextStones[key * 2024] ?? 0
            nextStones[key * 2024] = newVal + value
        }
    }
    return nextStones
}
// print(solution.map { "\($0)" }.joined(separator: " "))
print(stones.count)
// .map(\.count)
// .reduce(0, +)
// look3(at: inputSlice[inputSlice.startIndex..<inputSlice.endIndex], x: 35)
print(Date().timeIntervalSince(now))

// @MainActor
// func look4(
//     at stones: [Int],
//     x times: Int
// ) -> [Int] {  
//     if times > 0 {
//         if stones.allSatisfy({ stone in
//             map2[stone] != nil
//         }) {
//             return stones.map { map2[$0]! }.flatMap { nextStones in
//                 let result = look4(at: nextStones, x: times - 1)
//                 map3[stones] = result
//                 return result
//             }
//         } else {
//             let result = stones.flatMap { (stone: Int) -> [Int] in
//                 if let cache = map2[stone] {
//                     return cache
//                 } else {
//                     let nexts =
//                     next(for: stone)
//                     map2[stone] = nexts
//                     return nexts
//                 }
//             }
//             map3[stones] = result
//             return look4(at: result, x: times - 1)
//         }
//     } else {
//         return stones
//     }
// }
@MainActor
func next(for stone: Int) -> [Int] {
    switch stone {
        case 0:  // flip
            return [1]
        case _ where stone.numberOfChars() % 2 == 0:  // split
            let numberOfChars = stone.numberOfChars()
            let d: Int = Int(pow(Float(10), Float(numberOfChars / 2)))
            return [stone / d, stone % d] // split
        case _: // multiply
            return [stone * 2024]
    }
}

extension Int {
    func nextMagnitude(order: Self = 1) -> Self {
        if self % order == self {
            order
        } else {
            nextMagnitude(order: order * 10)
        }
    }
    func magnitude(order: Self = 1) -> Self {
        nextMagnitude(order: order) / 10
    }
    func numberOfChars() -> Self {
        Int(log10(CGFloat(nextMagnitude())))
    }
}
// https://www.hackingwithswift.com/example-code/language/how-to-split-an-array-into-chunks
extension Array {
    func chunked(into size: Int) -> [[Element]] {
        return stride(from: 0, to: count, by: size).map {
            Array(self[$0 ..< Swift.min($0 + size, count)])
        }
    }
}
