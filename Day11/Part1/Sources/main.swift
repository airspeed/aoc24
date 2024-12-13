// The Swift Programming Language
// https://docs.swift.org/swift-book


import Foundation

let now = Date()
let input = """
125 17
"""
let solution =
performPart2(input: input)
print(Date().timeIntervalSince(now))

public func performPart2(
    input: String
) -> Int {
    let solution =
    look(at: input, x: 75)
    .trimmingCharacters(in: .whitespacesAndNewlines)
    .split(separator: " ")
    .count
    print(solution)
    return 0
}

func look(
    at stones: String,
    x times: Int
) -> String {
    if times > 0 {
        print(times)
        return        
        look(
            at:
                stones.split(separator: " ").reduce("") { acc, next -> String in
                    switch Int("\(next)") {
                        case 0:
                            return acc + "1 "
                        case .some(let number) where number.numberOfChars() % 2 == 0: // flip
                            let numberOfChars = number.numberOfChars()
                            let numberOfCharsIndex: Substring.Index =
                            Substring.Index(utf16Offset: numberOfChars / 2, in: next)
                            return acc + "\(Int(next[..<numberOfCharsIndex]) ?? -1) \(Int(next[numberOfCharsIndex...]) ?? -1) " // split
                        case .some(let number): // multiply
                            return acc + "\(number * 2024) "
                        case .none: // pass space on
                            return acc + next
                    }
                },
            x: times - 1
        )
    } else {
        return stones
    }

    // guard let nextToDefrag =
    //         reversedStore.firstIndex(where: \.isFile),
    //       let indexToDefrag =
    //         acc.firstIndex(of: reversedStore[nextToDefrag]) else {
    //     return acc
    // }
    // let defragBlock = acc[indexToDefrag]
    // if let nextAvailableSpace = acc[..<indexToDefrag].firstIndex(where: { $0.isFree(defragBlock.count) }),
    //    nextAvailableSpace < indexToDefrag {
    //     var newAcc = acc
    //     newAcc.remove(at: indexToDefrag)
    //     newAcc.insert(Array(repeating: Block.free, count: defragBlock.count), at: indexToDefrag)
    //     newAcc.remove(at: nextAvailableSpace)
    //     newAcc.insert(Array(repeating: Block.free, count: acc[nextAvailableSpace].count - defragBlock.count), at: nextAvailableSpace)
    //     newAcc.insert(defragBlock, at: nextAvailableSpace)
    //     return defrag2(
    //         acc: newAcc,
    //         reversedStore: reversedStore.removing(at: nextToDefrag)
    //     )
    // } else { // nop
    //     return defrag2(
    //         acc: acc,
    //         reversedStore: reversedStore.removing(at: nextToDefrag)
    //     )
    // }
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
