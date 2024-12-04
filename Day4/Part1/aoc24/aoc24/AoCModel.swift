//
//  AoCModel.swift
//  aoc24
//
//  Created by Francesco Puglisi on 04.12.24.
//

import Foundation
@Observable
final class AoCModel {
    var result: Int = 0
    func perform() {
        let start: Set<[WordPart]> = Set(wordSearchMap
            .filter { key, value in value == Xmas.x.char }
            .map { key, value in
                [WordPart(point: key, char: .x)]
            })
        print("X: \(start.count)")
        let result: Set<[WordPart]> =
        Xmas.allCases
            .suffix(Xmas.allCases.count - 1)
            .reduce(start) { result, xmas -> Set<[WordPart]> in
            let relevant: Set<WordPart> =
            Set(result.flatMap { start in
                start.flatMap(\.connectedNeighbours)
            }.filter { $0.char == xmas })
                print("xmas: \(xmas.rawValue)")
                print("relevant: \(relevant.count)")
                print("result: \(result.count)")
            let newSeries: [[WordPart]] =
            relevant.flatMap { (wordPart: WordPart) -> [[WordPart]] in
                result.map { (resultPart: [WordPart]) -> [WordPart] in
                    if resultPart.last?.connectedNeighbours.contains(wordPart) == true {
                        resultPart + [wordPart]
                    } else {
                        [] // erase
                    }
                }
            }
            .filter { !$0.isEmpty && $0.isInline }
            return Set<[WordPart]>(newSeries)
        }
        .filter { $0.count == Xmas.allCases.count && $0.isInline }
        print(result)
        print(result.count)
        self.result = result.count
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
        [w, e, n, s, nw, ne, sw, se]
    }
    func isAdjacent(to other: Self) -> Bool {
        neighbours.contains(other)
    }
}
let testInput = """
MMMSXXMASM
MSAMXMSMSA
AMXSXMAAMM
MSAMASMSMX
XMASAMXAMM
XXAMMXXAMA
SMSMSASXSS
SAXAMASAAA
MAMMMXMMMM
MXMXAXMASX
"""
let input = """
MMSSMSMXAMXMSSSSMMXSSMSAMASASXXAAXMAXXAMXAXSXMAMXMMMMSSMXMAAAMXMMMXXAMMAMSAMXXAMMMAAMMMSMMMMMXXSAMXMASXMXSMSXMXMMMSMSAMXSSMMXMMASMSMSMMMAMMS
AASAAAXMSMMAMAXAASMMAAMASXMMSASMSSXASAMXXAXMASAXXMMMAAAXMAMXMSAMSMSSMSMAMMMMSMAMASMMSXMAXXAASXAXAMXMASAMMSAMXMXMAAAXMASXMAMSAXXMSAAAAAASASXS
MXSMMMMAAMAAMXMSMMASMMMAMAAAMAMAAMMAXAMXSSXSAMSMSAMMMSSSMSXMAMAMXMAAXXMMSMAAASAMXSXASMSMSXSMSAMSXMAXASAMAMAMXMASMSXXSAMMSSMSAMSASMMSMSMSASAS
MMMASXSSMXSASXAXASMMAXMMSSMMMXMMMMSSSMSMMAAXXMAXXAMXMMXAAXAXASXMAMSXMSAMXMMSXSXSXMMXMAMXMAMMXAMAMMSMASMMASXMSSXSAMAAMAMMAMXMAAMAMMXXXXXMAMAX
SASXMAAXXMMAMXMMAMXSXMMMXASMMMMXSAAAAAAXMMMMMMXXMAMXMMSMMMSMXAXXXMAASAMXASXMAXXAMXASMSMAMXMASMMXSAAMXMASASAMAMAMAMMXAAMMAMXMMMMMXSAMASMMXMXM
SXSAMXMXMSMAMAMSAMXMXXAASAMXXASAMMSMMXMSMAMAMMASXSSMAAAAAAXMMMMXSMMMSAMMMMAMAMSMSMMSAMMMSSMAMXAXMMMSMSXMASXMASAMAXXAXAXSASAXAXXAAXAMAMAMAMAA
SASXSASAAASMSMMAAMXMSXMMXASXSSMXXAMXSMMXMASMXMXSAAMMMXXSMSXSAASMMSMASAMAAXMMAXXXAAXMXMASAAMAXMMSAMMAAXAMXMMSAXXXSXSAMSMSASXSASMMSSXMASAMAXXX
MAMXSASMSMSMAXMSSMXXMASMSXMASXMSMXSAXAAMMXSXXSMMMMMSMSAMXMASMXMAAXXAMAMSMSXSMSMSSSMSMSXSSSMXSASMASMSMSSMXMAMMSXMXAMXXMASMMAMAXXXAMXXXSXSSSSS
MAMMMAMXAXXMAXXAMXMASAMAASMSMAXXAAMMMMMSMAMXAMAXMMAAAMAMAMAMMSSMMMMSMSMAMSAMAAAXAMXAASAMAXXMAXXMAMXAMAAAMAXXMAXAMXMASMAMMMAMMMSMMSSSXXAXXAAA
SASXMAMSASAMXSMMXSMAMAMXMAXMSAMMMMMSASAMMAMSASXMSSMMMMAMXMSXAXXMASMXAMSSSMAMXMSMSMSMSMAMAMXAXMXMMSSMMSXMASXSSSMXSXXXXMAMXXAXAMXASAAMAMSMMMMM
SXXMMSMMASMMAMASAAMXXMMMXMAMAMXXMAASAXAXMAXAAAAAAAASMSSXSXXMSSMSXSAMMMAXAMXMSAMXAAXMMMAMMSMSASXSXAMXAAMSXXAMAAXAMMMMSSSSMSMSSXSMMMSMAAAXMASX
XMSSXMAMAMAXASAMSSMSXXSAAMXXAXXSXMMMASXMMSSMMMMMSSMMAXMASXMAMAAAXMAMXMASXMAMAMXXMSMAASASXAXMAXXMMMMMMXMXAMAMSMMXSAMAXAAXAAMMMASMXXMXXSSSMASM
MMAMASAMXSXMMMMXXXAMAASMXMMMMAMSAMXMMXMAXAMXXXXXMXAMXMMAMAMMMMAMSXASASASMSSSMMXSAXXSMSMMXSSMSSXSAXAASXMMXXAMMAMXAXSMMMMMMMSAMAMXMASXXMXAMASM
AMASMMMXMXAAXAXXAMAMMMXAXXAAAAASXMASAAMXMMMAMSASMSXMXXMASXMMSMMAMXAMAMAMAMXAAAMMAMAXAMAAAMXMXMAMSMXMSASAASMMMXMAMAXMSAMMSMSASMXXASAMXSXMMASX
MSASAASXSSSMMSSSXXAXMXMMXSSSSSXXMAMAMSMSMXMAXXAAAAXAMXSAMASAAAMSMSMMSMSMSSXSMXSMSMMMMMMMSSMSAMXMMSMAXAMMXMSASASMSMSXXAXSAASAMXSMXMAAMSAMMXSM
MMMSMMSAAMXMXMAMAXSMMXXSAMXAAXXMASXMAMAXMAMMMXSMSMXSAMMXSAMSMSMAAAXSXAXAXMAXSXMAMXXAAAXMXAMSMSMSAAMMMSMXMASMMASAAASASXMSMXMXMAXMAXAMXMAMAMMM
XMAMXAMMMMAMXMAMSMXASMSAMSSMMMAXAMXXAMSMSSSSSMAAXMAXXAAAMMMMXAMMSMSMMMMSMMSMAMMAMMSSSSSXSSMXMXAMMMXAXAAMMAMXMAMMMXMAAAXXMSMXMXSXAMSMSSMMMSAA
MMASMXSMMSASMSAMAAXAMXMAMAAAXSMMSSXMXXAAAAAAXAMSMMMSSMMMMXAXSMMMMMMXAMAXAMMAAAMASXXMAAMAMXMXMMSSXMSSSMXSMXSAMXSSMMSMSXMSMAMAMXXMMMXAXAXSASMS
XSASMSAMXSXAASMSMSMSMSSMMSSMMAAAMMXMSSMSMMMMMSXMASAAAXSSSMMXSAASMMSSXSASAMASMMSASMSMMXMASAMASMASXXAMAXXMAXSASXMMAMXAXXMASMSASASASXSSSMMMASAX
XMSSMAAXMSXMAMXAAAAXAMMSAXAMSSMMXMAXMAXXXMXAMXXSAMMSXMASMAMAXMMMAAAAXMXSXMAMMXMAXAXXMASASASASMAMMMMSAMXMXMSAMMASXMMMMAMAMXSMSAXSAAAAXXAAAMAS
ASAMXMXMAXAXMAXMSMSMXMAMXSAXAAXAASMSSSMMMAASMMMMMSXMAXXXSAMSSMXXXMMMMSMMXMMXSAMXMSMSAMMASXXASMASAAAMASXXMAMAMSMMMXMASXMAMMXAMAMMMMMMMXMAXXXA
MMMSXXAXMMAMXSMAAAAMAMXMASAMXMMSMSAAXAAXMAAAAAAAAXXMSMSMSXXAAXSSSMSXAXAMMSMAMAXXSXAMSSMAMXMAMXXXMXMSXMMMAMMSMSAMXMXXXMSSSMMMMAXAMXMASXSSMSXM
XSXAMMSMSAMSAMMXMMAXAXMSAMXAXXXAXMMMXSAMXSXXXMMMMMSAMAAAXMMSSMMAAAAMSXSAASMMSSMMAMSMAMMMSAMASXMSSSXMMAXAXSAXSXMXAAMMAXAAAXAXMXSMMAMXMXMAAASX
SAMXSAMAMAMSAXAXSSMXMMAMASMSSMSMXMAAAMAMAMASMSMSAAMAMSMMMAAMAXMAMMMSMMMMMMAAAAMSAMAMAMAAXMSASAAAAXAXXXMXXMAMAMXSASAMMMMSMSMMSAXMSMMAAAXMMMAX
SSMAMASMMAMMMMSMMASAAMSMXMXAAAAAAMMMMSAMSXMXAAAMMMMAMAAMSMMSAMMSXXXMXAASXSMMSXMMASAMMSMMSMMAMMMMSMMMSXSXMMSMMXMAXMMXMAXAAMAAMAMXAASMSMSXXXMM
XAMXXAXAMXXXSAXMSAMMXMXAAMMSMSXSMSSXMSMMXAMMMMMMMSSSSMSMAAMMMXXXXSMSSSMSAAXXXMSSMMAMMAMMAXSSSXMAMAXXAAMAMAAAXXMAXMMMXSSMSMMMSAXMAXXAAXAMXSXS
SSMSMSSMMSMMMAXAMXMSMXSSXSAXMXMAXAXAMXMASAMXXAXMXAXMAXAXSXMAMMMSMMAAMXAMMMMMAMAAAMMMSAXSAMXMAAMAXXMXMMSAMSSMMMSAMMAMXMAMXXSASXASMMMSMMXMASAS
MAAAAXAAAAASMSMSMAASXAXXAMMSMXASMSSMMMMMSAMXSMSMMMSASXXXMASXXAAXAMMMMMSMAXAAAMSSMMMAMXMMMSMSSMMSSMXMXXMAMAAXSAMASXSSXSAMMAMASAMXAXXMASXXAMAM
SMMMSSSMSSSMAXAAXSXSMMMSAMAAAXSXAXXXAMAMMMAAMXAXSXSAMXMMMMAASMXMAMXSAAASXSSSXMMMAAMSSSMXXAAMAXXMAXXASAMMMMSASMMXMAAAXSAMXAMXMMXSXMXSMMMMSMAM
XAAXXAAAAMAMXMSMXXMXAXXMASMXSMMMMMSMMMAMAMMSMMSXMXMAXXAAAAAMAAMSSMASMMMSXAAMXMMMMXSAAAASMMSSSMMSAMMMSAMXSSMASAMSMXMMMSAMSMSMXMASMMASAAXAAMAX
SSMSMMMMMMAMXAMMAMMMSAMSXMMXAAXMAAAASXMXMSAAMSMASXSMXMASXSSSMMXAAMXSASXXMMXMAMAAXMAMMMMMAXMMXAXMAMSASAMAMXMSMXMAAXAXAMAMXMAAAMXSAMASXMMSMSSM
XXMAXASXXSASMSSMMMSAAMAXMASXSMMSMXMSMASAAMMMXAXXMXAAAAMMAMAXXMMSSXAMMAXMAXSSMSSXSAAXXXXSXMMASMMAMXMASMMMSAMXAASAMXMMMMMMXSXSMSXSMMXSAXMXMAMA
MMSAMMSAAXAMAMXAAAMASXSXMXMMXMASAXSAXAMMSMAMXASMMSXSMSAMAMMMMMMXMMMMXMAXXSAMXMAAAMASMMXMMMMXMSXXXMMMMXAAXMSMSMSAXXXXMASMMSXXXXXMXSMMMXSSMASX
XMAMXSMXMSSMMMSAMXSSMMMAMMXXAAMMAMSAMXSXAMASMMMAAMMMXMMSXSAMAAAAMASXMXSXMAMMASMAMXSAMXAAAXXAXAXMASAAXSMSMMAAAAMMMSMMSASAASAXASXMASAMXMMXMASA
XSAXXMASXMAAXMAMMAMMAASAMASXSSSMSMMXMASXMMASASMMAMXSAMXMASAMSSSMSAMAXAMAMXMSAXAXXMXMAXSSMSSMSMAMXMASMXXAAMMSMSMAAXXAMSSMMMMMXAAMASAMMASAMAMM
XSAMMMXMASXMMASAMSSSSMSASMSAAAAAMXSAMMMMXMMXAMASAMXMAMAMMMSMXAXXMASMMXMAMAMMMSSMMMMMSMMXMXMMAXMASMXMMMMSSMXXAXMMMSMXMMMXMAAAAMSMASAMASAXSAAX
ASMXMASXXMMMSAMMMAAAXASAMXMAMXMXMASXXAAXMSSMAMXXSXXMASAXXAMMMMMAMAAXSMSMMMSAXXXSXAAAAXXXMASMMMSMMSAAAXXAAMSMAXAXAAMSMXMASMSSMXAMXSAMMXAMMMSM
MXMASMSAMXMAMXSXMMSMXMSMSAMMXMXAMXMASXSSMAXSAMSAMXMSASMSMXSAXMAXXMMAMAAMAAMASXAXSSMMSMXXMASAXAMAASMSMSMXSXAMMMMMMSAAMASMSMAAMXMMASAMXMXSXAAA
XMSMSAMXMAMASMMMAMXXAAMASAMXAAXAAXMXMMAAMAMSXSMXMAXMASXAAXSXSASMSMSAMSMSMXSAMMXMAXMXAMAAMXSASMSMMSAAXAAAMMXAAMXMAXMMSASMXMSSMMXMMMAMMMAMMMMS
MXAAMXMAXXSASAAMMMXSMSXAMAMSASMMMXMMASXSMSXXMSAMXMSMXMXMSMSAMAMAAAXAXAMXMXMAXMMXSAMSAMAXXAMAMMAAMMXMSMSMSASMMSXMASAXMXSXXXAAAMXSMSSMAMASXAMX
ASMMXMXSMAAMSMMXAMAXAXMMMSMMAMMASAASAMAXAMXSAMXSAAXXAMAXMAMXMAMSMSMXXSAMXAXMASAAXAMSAMXAMXMAMSSMMAMXMXMAAMSAAXAMASAMMXSAMMXSMMAXMAAMXXAMMMSA
MXSMAMAXMSMMXMASXSXMAXAAAMAMSXSASXXMAMAMXMASXSASMSMSSSSSMMMAXXMAAAAMSMSMSMXSASMMMSMXMMSXMMMAXMAMSMSASAMXMXSMMSXMAXMMXASMAMXMMMMSMSSMSMSXSAAX
XAXMMMSSXAXXAMASAAMMSSSMXXAMAAMMSMXSAMAMAXXMAMAMSAMXAAASXASMSMXMSMSMAAAXAAAMAXAAAXXMSAMAMAMMSSSMAAXXSMSXXXXXMXMMMSMSMASXSSMMASMXXAMMAAMAMASX
SSSMXAMXXSSSMMAMMMMAMAAXXMSMMXMAXMAXMSMSMSSMAMMMSMSMMMMMSXSAAAMXMAXMMMMMXMSMSSSMSSMXMASMSMSAAAXMMSMASAMXXMASMMMAAAMMAXMAAMXMAMXXMASXMSMMMAMA
AAAXMSSMXXAMAAAXXXMXSSXMAMMAXSMSSMSSXAAAAAMMXMXMXMXMXXXAMSSMMSAMXAMXSMSMSMXAAAAAXXAXSAMMAASMMSMXAAMMSAMXAMXAAASXSMSXXAMMMAASXMSXSASXMAMXMAMX
MMMMAMAMSMAMSSSSSMMAMMAXMASMMSAAAAAXXMSMMSSXSAMSAMASXSMAXAXAMXMXXSXMASAAXSMMMXMMMASXMAXMMAMAAMAMXXXASXMSSSMSSMSXMXMASXXSMMMSAASASASMSASASMSM
XAXXMXAMAAMMAXMAXAMAMSXMSMSMAMMMMMMMAMXASAAAMXMMAMAXAMXSMMSSMSMXXMASMMMXMAMMXMSASXMMXAXSSSSMMSXMXSMMXAXAAAMMXMSASAXXAASXXXAMMMMAMAMXXAMXXMAA
XASASXSSXSMMXSMSXSMSXMAXXXMMSMSXMSXMSSMMSMMMMASMMSSMAMAXAAXAAAAXSSMMXSAAXAMSAMSAAXXXXXXXAAXMXXASASASXMMMSMMSAMMAMXMMSMMMMMMAMXMAMXMXMSMSSSMM
ASMMXAASAMXXAXAMAXXMASXSXSMAMXXASAXMAAAASXMASMXAAAXMAMASMMSMSMXMAAAXMMSXMAXXAXMAMMASMSMMMMMSSMMMAXAMAXXXAMXSAMMSMSXAASAXXASAMMMMMASMMAASASMX
MXAMMSMMXMAXAMXMAMXMAMAXAXMASXSMMMMMSSMMSASASXSMMMSSMSXSAMXAXMAXSMMMAMAMXMMMSMXAXAMAAAMAMXXXAASMSMSMMMSAMXMSXMXXAMMSMSSXXASXXAAASXXASMSMAMXX
XXAMXAAXXASMSMXMMSASXMMMSMSASAAXMXAAXAAMXXMXSAXXAAMAMMAMAMMSMSXMAAAXSMMMXSAAXMSSXSSMSMSSMMSMSMMAAAXSAMXMASXMSMAMAMAMXXAXMXMXSSSXMMXXMMMMXMMS
MSMMSMSAAAXAXMXSAMXSAAXAAMXMMXMXXXMSSMMMMSAAMXMSXXSAMSASAMXMAAMSSMMSMASAAMMMSAXMAMXAAASAAAXAXXMMMSMXXMAMXSMMAMMSAMXSSMMXMAAAMXMAXSSMAXMXMASA
XASMAMXMMAMAMSXMMSMSMMMSSSMSAAMMSXXXAXAASMSSMSMXMXMXMSASMSAMMMMXAMXXXAMMXSXXMXMMMMMMMSSXMSSMMMMAXXMAMMSMXXASMSAMXSMAXASXSMSMSAMAMAASXMSMSMAM
XAASMSAXMAAMXSMSXXXMAMXMAAAMMSAAAMMSMMXSAAAMMAXAAMXSXMXMAMXSAMXMXMSAMXSSMMMMAMXAMAXASAXAXAXXAXXSSMSSXAAMMSMMMMAMAMMASMMAXAAXSXXAXMXSXAAAXAMX
MSMXXSAXSAMMAXAAXMMSAMXMXMMMXMMMMXAAXAXXMMMSSMSMXSAMXMAMSMMSASMMAMXMMMAXAAMMMASMMMMXXASXMASMMSMMAAAMMSMSAAMAASAMASMXSMMMMSMMMMSMSXAXMSMXMSXM
XMXSMMSAMSAMXMSMXSAAXSAMSSXAAXAAAMSMMXSXMAAXAXAAAMAMAXAXAAMSXMMMASASAMXXXXXASMSAASXSMXMASAXXAAAMMSMSAXXXMMXSXXMSXXMAMXAXAXXAXAASAMXMMXSXXMAX
SMAMAAMXAXXMAAAXMMAXMXAXAXAMMSMMXMAASASASMSSSMMMMSSSMSSSSSMMAMXXASASASMSSXSMSAMMAMAAMXSAMXSMSSSMXXXMASMSASAMXSMMXMXAXSXSSSSSSSMSXSMMSAMXMMAM
AMAMMXSMXMASXSSSMSAMSSSMMMMAMAMAMXSAMASAMXMXXAAMMAMXAAAXMXASXMXXMMXMXMAMAASXMXMASMSMMXMXSAXXXAAXXXAMXMAAMMAMAAAAAXMAMMXMAXAXMAMXMXAAMAXSAMXA
MSMSAAXAAMMMMXAAAMXXXAAMXXMASXXXSMMMMMMAMXSAMXSSMSSSMMSMMSXMXAXSSSSSMMMMMMMAXAXMMMAAMXMMMMMSMSMMSSMMSMMMSMSMSMMSXSAMAMXMXMXMSAMAAMMMSAMXSASX
XAXAMMSSMMSAMXMMMMSSMXMMAMMASMSSMMMSAXSXMAMAMAXXMXMASXAAMSAMMSMAAMAAMAASXSSSMSAMXXSXMAMMAAAXXAAAAMAAAAAXMAMAAXXAMXMXMAXMAMAAMASASXAAMXSAXMAX
SXSMSAAAMASASXAXXMXAAXSMMSAMXAXAAAXMAMSMMMSAMSSSXSXMASMSMSAMAXMSMMSMMAXSAAAXSMXMAMAASXMASMSSSSMMMSAMXSMSMAMSSSMXSAAASMMXASXSSXMAXXMSSXSAMXMX
SMXAMMSSMMSAMXMMSASMMMXAASXSSSSMMMSMSAMXXXAMXAAXASMXAMMMXMAMASMMMAXMAMXMAMSMSMMSSSMMSAMAMAMXAXXSXMASMMMMMXXMAMAMSXSXMAXSASAAXAXASMXAXXMXMMXX
SAMSMXMAMAMMMSXAXXXAASMMMSAAAXXAAAXMMAAXMASXMSMMXMAMXMAXMMMMMMAAMXMXSAMXSXMAMMAAAAAXSMMMXAMMMMASASAMAASXMXXMMMMXMMMXMAMMXMMMMSMAXMAMAMAAMXSM
XAMAAAXMMXXMASMSMSMSMSAXAMXMMSSSMSSXSXMXAAMXAAMAXMXMMSXMAASAMXSMSSMMMAMAMAMMMMMSSSMMXAAMXMMAMSASAMASXMMAMMMMXXXAAAAAMAMMAMXXAXMMMSAMAAXMXAAA
AXSXXMSSSSXMXSXMASAAASAMXSAXXXAAAXAXXASMSMSMSMSXXMASXAAMSMSASMXAAXAAXAMMSAMAAXAMXAMMSMMSAMMXMMAXMSAMXSSMMAXMAMSSSMSXSAXSASAMXSASASASXSAAASXM
MXMASMXAAMMMAMAMAMXMMMXMAXMXMMXMSSMASMMAAAMMMMAMMMMSMMXMAAXAMXMMMSMMSSMXSXSSXSASXMMAMXASASXMXMAMASASAMAASMMMMMAMXXAASXMSASXSXSXMASXMAMMMMXAS
XXSAAAMMMMAMAXAMMSMSMSAMSXSASAMXMAAAXAMXMMMAAXAXAASXMAAXMSMSMAAXAMAMXXXXMXMAMMMAMXMAMSMSXMASAMAAMSAMMSSMMSAASMMMSMMMMXXMXMAMAMXMAMMMXMSASMMM
XXMASXSSXSXSSSSSXXAAAMXSAASASXAASXMMSSMASASXMMXSMMMAMSMXAAXAXMMMMSSMMMSAMXAMXSSMAMSSMSAMMSMSASMSXMXMAXASAXMAMASAMASAMXSMMMXMMMAMMMSXMAMASMXA
SMSMMAMXAAMAAAAXAMSMMMMMMXMAMMSXSXSAXXMASASAMSXMMSXXMASMSMSMMSAMMAXAAASAMXAMAXAXSMAMMMMMAAXXAMXXMASMMSAMMSXMMAMXSASMSAAXXASXSSXSAASAMAMSMMSS
AMAAMXMMXMSXMMAMMMXASXMASAMAMMMMXXMASMSMMMMXMAASASMSMAMMAAXXASASXASXMMSAASAMXSSMMMMXAAAMMSSMSMMMXSAAXMMMXMXSMXSMMMSAMXSMMASAAXASMSMXMAMXAAAM
MSSSMAMSMXSXSMXMAAXSAASMSAMAMASAMXSMSAAAASAMXSXMASAXMASMSMXMMSMMMMMMSMXAAMAXXAAASAMMSXSSMXMXXAMAXAXAMMSMSMAXXXXMAAMMMAXXMXMMMMMMMMMSSSSSMMSS
XXMAMASAMXMAMSAMXMSMMXSMSXSXSAMXAMXAMXSSMSXXAMXXAMXMASXAAAXSXMXAAAASAMXMASMMMSMMMASAASAAXAMXMAMSSMMSSMAAAMMSMMMSMMSXMSXXXAXAXAAXAMXAAAXAAAAM
XXMASMSASMMAMAXMAXAXXAMAMAAAMMMXSAMMMAXAXXXMSSSMASASXMMSMSXMASXXMXXXASXMXAAMAMXAXAMMSAXXMASASAMXAXAAAXMSMXAAAAXXXXMMXXASMSXMXMSSXXMMXMXXMMSS
MMAAAASAMXMMSMMMXXSMSMMAMXMMMXAAAXAXMSMMAAMXAAMXXMXMAXAXMAMSXMASMSMMMMAXSSSMAMMSMSSXAMSMSMAXSMXSMMMSSMXAXMMSSMSMAMXXMSMXAMXSAXXMMASAMMXXMAMA
AAMXSAMAMMMAAXAXMAMASXMAXAXAXMASMSSMXMAXXAAAMSMSMSASAMSSSMAXASAMXAAASMSMMMXMASAAAAAAMXAASXMASAMAXXAAAMXMSSMAXAAXSAMXMAAMSMAMAMMASMMASAASMSSS
SXSAMXSXMAMSMMASXXMAMAMSSSSMSXMXAAAXASXMAMXXSAAAAMAMAMAAMSAMXMASXMSMSAAMAAAXXMXMSAMMXMMSMAXAXMAAMMMSASXMAMMMMSMMMSAAMASMAMMMAXMAMASAMXMSAXAX
MSMXSMMMMSAMXMMAMXMMMSAAAAXMAMAMMMMMMSSSXSAXXMSMSMXMAMMSMXMAMSSMMAMAMXMMASMSAMXXAASXXMSAXXMMXXMSMXMMAMXMASXMAXASAAMMXMMXXSSMMSMASAMASMMMXMAM
XXXMXMAAAXXMASMAXAXXAMMMSMMMAXMASAMMXSAXAMASMXXAXMSSSSXXMASXXXAAXSMAMAXXMMMXMXMASAMMAMMAXSASAMXAAAXMMMXMASAMMSAMXSXSAAXAMAAAAMXAMXXMMXAAMMXM
SMXMAMMXSXAMAXSSSMXMXSMXAXAMXXXMXMMMMMAMAMAMAAMAMAAAXXXXSAMXMMMMMMSASASXXAMXMAXXMAAMSMMSMMASASMMSMSMAMSMMXMMMMMXXXASXSSMMSSMMMMXSXSXXSAMSSXM
ASXSAMMMXMMMAXXMAMAMMMMMMMSMSXSSXMASASMMSAXSXMXAMMMMMSMXMASXSASAAASXSAMXSMSASXSXXSMXMAAAAMAMMMMAAXAXASAMXSAMXAMMSMAMAAAAAXXXSXSMSASAAXXSXMAS
MSMMMXXAXAXAXSASAMMXAAMAXAMASAMXXSASASAXXAAMAMSASXSAAAAAXXAASASXSMMAMAMXAXSMMAAMXMMASMMSXMSMMAMMMSASMSMXMASMMAXAXMAMSSSMMSAASXXAMAMMMMMAASMM
XXAXAAMXMMMMMSAMXSXSSSSSMAMAMXMAAMAMMMMSAMXMAMXAMASMSMSSSXMXMAMXMAMMSSMMMMSXMSMMAXSASAMMMAMXMAXAMMMSXMXMAXMXSAMSMSXMAAXMSMMMXAMMMXMAAAMMAMXS
MMSMMXSAAXAXXMMMMAMAAAAMMXMAMXMASMMMAXXAXMXMAXMAMXMXXXAAMXMAMXMASAMXAXAASAMXXMASXXMASXAAMAMASXSXSAAMMMAMMAMAAAXAASXSMMMMAXASXXMAAASXSXSXMMAS
SAAXMAMXSMMMSAMMAAMMMMMMAXXAMSAMXMASMSXASAXAAXSXMSMASAMAMAMASAMMSAMXASXMMMSMXMMMMMMMMMSXMAXXMXAASMMSASAXSAMXMSAMXMASXXMSMSSXMASXMXMXMASXSMAS
MSSSMMSMXMMMXAMXSXSAMXXMAMMAMXAXXXXAXMMMXMSMMMMAMAMMSASAXSSMMASXXXMMAAMSXMSXSAAAMSSMMMMASAMSAMMMMAMXXMAMSMMSXXMXSMMMAXMAMXXAXXMASMSMSASASMMM
MAMXXMAMMSXSSMMXMXSMSMMMAMSSMSSMMMSSXMASMXSASASASASMSAMAXXAMXSAMXAXSMSXSAASAMSSMSAAAAAMXMAMSAMSASAMSSSXXXAAXMASAMAXSSMSMSMSMMMMMAAAMAAMXXAAA
SAMMMSAMXAAXMSMAMAMXSAASAMXXAXAAAXAXASXSAMXASASASASAMAMXMSAMMAAXSMMXAXASMMMSMAMXMMSMMSSXSMMMAMXASXSAMXMASMMSMSMMXSMMXAXAAAAMAMAXMMASMXMSMMMS
AAAAMMMMMMSMAAMAXXSAMMMMAXXMMMSXMXAXMMMXMAMXMMMMMMMAMXMXXMMMSSMMXSAMXMXMXSAAMAMSXMXXAXXXXMSXSMMXMMMMXAAAXAMSMXASAXAXMAMSMSASASXSSMASXSSMXSMM
XSMXSASAMXAMMMSXSAMXSAMSSMMAMAMASMSMSASXMSXSAAXAAXXXSXMSXAAAMAMMXMSSXMASAMXXMAXAMXMSMXMMMMMAMAMAXAASMSMXSMXMASAMASMMAXMXAMMMASAAXMAMMSAAASXS
XXMMSASXMSASXAAMMMMAXXXAAXASMASXMXAASAMAAMASXMSMSXSMXAAAXSMXXAMSAAAMASAMASASMSSMAAAAMAAAAAMXMASMSSMXAXMAMXAMMMSMMMMXSSMMXSSMAMMMMMMSXSMMMSAM
XSAMMAMAXSAMXMMSAMMMSMMSSMSMMMSMSXMMMSMMMMAMAMSMMAAASMMMXMXSSSMSMSSSMMASAMASAMXXXMSASXSSSMSAXXMAMAAMSMSMSXXXXAMXSAXAMAASAMXMMXAXAAASXMASAMMM
MSAMXAMXMMAMMMASXSASAAMXXMXSAMXASAXXAAXXXMASAMXASAMXAMXXAXAMAXAMAAXXXSAMMMXMMMMSXAMXXAMAMASMSMMASMMMMAAAMMSMMXMASXMSXSXMASAMSSSSSSXSASAMAMXS
ASAMSSSXSSSMAMXXXSMSMSSMSMMSXSMXXSMMSSXMMSMSMXMXMAXXMXSSMMSMAMMMMMSSMMMMXSAAMMAAMSMSMSMAMXMAAAXASAMXMMMXMAAAASMMSXAXAMMSXMASAAAMAXASAMXSMMAM
MXAMXXMAAAAMXXASAMXSMAMASAMMXMXMSMMMAMXAXXAXXSAMXXMMMMMAMAMXSSMASXAXXAMXASXSMSAMAMAMAXMAMSSSXSAASXXXAXMAMSSSMSAAMMMMAMASAMXMMSMSSMMMSMMXMMXX
MSSMMMMMMMMSMMSAMMASMASMSAMXAXAXAAXMASXSMMMMMAAASXSXSASAMXSMXAMASMSMSASMMMAXAXXXAMAMMMSMSAAMAMMXMASMMASXXAAAASXMMAAMSMMSAMAMAMXAXXXAAXXXMMMS
XAMAMAAAAXSAAXMASMXMXASXSMMSMSMSMMMMXMAMXAAMMMMSXASAMXSASMSAMMMXMXXAMAXMSMAMSMMSMSXSAAAXMMMMAMXASXMASAXMMSSMXMASXSXSAAXSAMXMASMMXAMSSSMXMAAA
MXSASXSXXXSMMMSAMMAMMXSAXMAAMAAAAASXMMAMSSMMAASAMXMAMAXXXMMXASAMMSMXMXMXAMMSMAXMASASMMSSMXXMAXSASASMSAMXXAMXAMMMAMMXXXMSAMSSMSAXAXAMMAAASMSM
AASXSMXXSXMSSMMSMMAXSXSASMSSSMXMSMSAMSSXMAAMXMMAMMSAMMSMXSMSMMASXAAXMAMMMSMAXAMXAMAMAAXMAXMMAMMAMAMXMMXMSASMXMAMAMMSMSAMXMASMSMSXSSSMMSMSAMX
MMSASASMSAAXXXAAXMAMSAMAMXAXMAMXMASAMAMASMMMSASAMASXXMAMAMXAAXAMMMXASMXXAAXAMXSXSMSXMMMSASXSSMMSMMMSXMAMMAMASMSSMMAAASXSSSMSXXXSAMAMMAXMXAXM
SXMXMAMASMMMXMASAXXAMAMMMMMSMMAAMASMMAMXMAAMAXXASXMAMSXMASXSSMMSAXMMAXAASMMMSAXXXAMSMSMAAXAAASAXASAXASXSMSMAMXMAMMMMMXAMAAXMMSMMMMAMMMMMMAMA
MASXMMMAMAAAXAMMASMMSXMXAASAAMSXMASAMASMSSMSMSSMMMSAMMASAXXAAAXXXMXMAMXMAAAAMMSAMXMAXAMMMMMSMMXSAMXXMMMMAAMXSXSAMXSMSMXMMMMXAAAAMMXSAAAMXMAS
SAMAAXMAXMMSAMAAAXAXAMSSMSSMSMXAMXMXMAXXAMAMXMAAMASAXSAMMSSSMMMSSMSMSAXXSMMSAMXXXAXMSMSAAXXMAXAMMXSSMAXMMMSAMAMMSXMAAAASMMXMSSSMSSMSXSSMASMX
MASMMMSSMXAAMXAMMSMMMSAAXAMMXASXMAMMASMMXMAMASMMMASAMMMXXAAAMXMXAAAAMSMXMXAAXSAMXXXXAXXXSSXSAMXSMAMASMSSMXSAMSMAMAMSMSASXAMMMMAAAXAXXXAXAXMX
SAMMXXMAASAMXMXAMAMAXMXXMMSMMXMXMMSMAMSAAXASAMMSMXXAXASXMSXXMSASMMMSMXXAMMSMSMXSAXSSMSXAXAMXMSMAMSSXMMAASMSXMAMASMMXAMAMXSAAAMMMMXSMMSSMMSSS
MASMXSMXMMAAMSSXSASMMXSMMMAAMXXAMAMMSMMXMXAMMSMAXSSMMMXAAMASAMAMMAMXXXMMXAXXMMAMMXXAASAMMAMAMAMXXAMASMSMMMMMMSSMXXSMMMSMAMSSSSMXSMXAXAAAAAMA
SMMMAMAMXSXMSMMASASMMAMAASMSMMSMSAMXMSMASMSMAAXXSMAXSMSMMMMXAAAMMSMSXMASAMSAAMAMXMMMMMAXSAMASMSMMASXMAXAMXSAAMAMXSMSMAAMAMMXMAMAMXSMMSMMMSSM
XAAMXMAAMMMMAAMAMXMAMMSSMSAMAAAXSXMSMMMAMAAMSSSMMXXMAMSXMAXSAMXSXXASASAMXXSMMSMMSAMSXSSMSXSASXAXSXMASASAMMMMXXAMSAAAMSXSMMSASXMMXAMXAMMSAMAX
SSMSMSMXAAAMSSMMMAMAMXAXSMAMMMSXMAMMASMSSSXXXMXAXXXSXXMASMMMSMASXMMMAMXXSAMXXAMAAMAMAMAAXMMXMMAXAMSAMAXAMAXMSSSMMMSMXMASAASASXAASXMMMSMMASMX
XAAXAAXXSSXMAAASXXMASMMXAMAMXMMAXMMMXMAMAMXXMASMMXMXMMXXMSAXAMASASXMXMXAMXSXSASMMXXMAMMSMXSAMXMSMMMSMMSMSMSAXXMAXXAXAMAMMMMAMMMMXXAAMAXSAMXM
XMAMSMMMMAXMXSMMASMMMXXXSMMSXSSSMSSSSMXMAMXSAMXAXAXAMXXMASXSXSXSAMXMAMMMAASXMAMMXMAXASXMAXMASAXAAXAXXXAMAAMMMMSXMXMAMMXMXXSAMXSAMSSMSMMMXXAX
MXMAAASMMMMXAXAMAMAAMMSMMASMMAAAASAXXAASAMAAAMSSXMSMXSAMAMMSAXMMXMXSAXAXMMSASAMMASMSMSAMMXMAMXSSSMMSXSASMMXAAAMXMMXMXMMSSMMAXMMAXMAASXASMSSS
ASXMMSMAAMXMASAMXMMAMAAAXXMAXMMMMMMMMSMSASMSSMAXAAAXXAAMXSAMAMAMSMMMSSSSMXSAMMXMASXAAXAMXSMXSAMXXAXSAXAMXXSSMSMAMAXXAMASAMSSMAXMMSMMMSASAAAA
SXMASAMSMMAXXXAMXASXMSMSMMSSMXXXAAXAXXXXAMXAXMASMMMSSSMMXMXXXAMXAAAAXMMAMAMAMAAMMMMSMSMMXMAAMAMXSSMMAMSMSAMXAXXMXAXSMSMSAMAMASXXAAAXXMMMMMMM
ASMMSAMXMSXSMMAMXMSAAXAXAXAMXAXSSSSSSXMMSMMMXMASAMAMMAASXMSMXSSSSSMXSMSSMXSAMMXXAAXXMAXMXSXMXAMXMAAMAMAAXXXMXMASMMMXAAASXMXMXXAMMXMMXMASXXXA
MXMASMMAMSAAAASMSSMMMMAMXMAXAMAMXAAXMAMAAAAXXMXSAMXMMSMMAMAXMXAAMXMAAMAAAMAMMXASMSMMSMSMAAAXSSMMXSMMMSMMMMXMXSMXASASXMMMSMASXXMAXAASAMXSXAXA
MMSASMSXMMMMXMXAXAXMXMXMASXMSSXMMMMMSSMSSMMMMMMXMXXSAXMSSSMSXMMMMAMSXMMSMMAMMMMAAAXAAAAMMMSAXAAMXXAXAMAMASXMASXMXMAMSAAAXMAMAAXAXSSMASAMXSMM
XAMXSMMXSAMXSXMXMMMSXMAMXMMXAAXSAMXMAAAXMAXXASMAMXMMASXXAAXMASXMMXXAASXXXSXSXXXMSMSSMSMSMAXMSSMMASAMXMXSAXAMAMMXSMSMSXMSSMMSSMMSXXAXAMAAAMAM
MSSSMXSASMSAAAAXMXXAAMMSSSMMMSXMASAMSMMMSAMASXMASASMMMMMMMXMMXAXMMMSSMASAMAXMAMXXXMMAAMXMMSMMMAMASXMMSMMASMMSSSMAAAAXASXAAAAAAAXXSAMXSXMXSAM
SAMAAAMAMXMMSXSASAMMSXAAAAAMXMMMAXXMAMXXMASXMASMSASAXASMSMASMSMMSAMXAMAMAMAMMXMAMAXMSMXSAMXXAXMMMXASXAAMAMXAAAAXMMMMMMMAXMMSSMMSMMAMXSAMXMMM
MASMMMMAMAXMAAMXSASAAXMMSSMMXXAMMSMSMSMXMASAMMAMMMMMSXSAASASMAMASASXSMXMASXSMAAASAMXMXASXXXSXMMASMMMSMSMMSSSMSMMXAXSASXSMMXMXAAAASAMXXAAASAS
SAMXMXSXSASMMSMASMMASXXAXAAMASAMXAMMXMXASAMXAAAMASAAMXMMMMSSMXMAXMAMXASMAXMAMXSMSXAASMMSMMXMAXSAXSAAAXAAXXAMAAAAXSXSASAAXXAAXMMSMMASMMMMASAS
SAMXMASAMXSASMMMSXSMMMSSSSMMAAXXSSMSASMMMMSMSSXSASMSMSXMXMASXSMMSAMXSASMSMSMMXMASXSASMXMASXSAXMXMAXSXMXSMMMMXMASMXAMAMMMMMXSASAXASXMAAMAMMMM
XXAAMMSAMASXMAAASMMAAXMAAMAMMXMMMMAMASXXAMSAAXMMMSMXAMAMXMASXSAAXAMAMAMAAXAASXMASXMAXMASXMAMXSXSSSMMXSAMMAXXXXAXAMXMXMMMSXAXAMXSMSAMSSSMMAXA
MSSSXXXAMXSMSMMXSAMSSSMMMMSMMAAAAMAMSMMSMSMMMSXMASXMMSAMAMMSXMAMXXMXMMMXMSMMMAMASXMMMMMMSMXMAXAMAXXAASASXSSMXMAXMXMXMAAASXMMXMASASMMXAXXXXMM
AAAMMMSAMXMMAMSAMMMAMXXSXMXASXSSXMAXXAAXSAMAMSAMXSAMXAAMAXMXMMAMXSXMSAMXMAMASXMASAAAAAAAMMSSSMAMMMMMMXAMAAXAMSMSMAXMASMMSAXAXMXMAMXSMSMSXSSS
SMMMAXSMMMSAMXMAXSMASMAMMSMMMAAAAASASMMSMMSAXMXMASAMXMMMXXSAXMAMXAAASAMXSXSAMAMAXXSXSSMSSMAAASXMXAAASMSMMMMXMAAAMXMAXXSASAMMSMAMAMSAAMAMAXAM
AXXMSMMAAXXMXMSMMASMXMAAMXAXMMMSMAXASAMXAASMMSXSASXMMMSSSMMASMXMMMSXSAMAMXMASXMMSMXAMXXAXMMSMMXXSMSASAAASXSASMSMMSASXAMXXXMAAXASASXMMMAMMMSM
MMSXMAMSASXMAXAAAMXXXMXSAXSMXXAMXMMSMXMSMMXAASMSASAMAXAAAMMMMASXSXXAMXSAMASMMXAXXAXAXXMASMXAAXAXSAAMMXMMMAXAXAAAXXAMMSMSSSSXSSMSXSAMXSXSAAXM
SMSASAMMAMXSASXSMXMMSMAAMSMMAMAMAXMXMAMMASXMMSAMAMAMSMMSMMAAMAMAXXMXMAMASASMAXXSSMSSMMXAMAMSXMXXMAMMMMSAMSMSMSMXMSMMAMAAAAAAXMASAXMAXAASMMSS
SASAMASMAMXMASMMMAMAAMAMXAXMAAMSSMMXSAXMAMMXMMMMXSMMXAAMXSXMMAMXMSMMMMSAMAMMSXMAAAAXAMMSSMAXASXXSSMSXASMSXAXMAMSMMMAXMMMSMMAMXAMSMMSSMAMAAMA
MAMAMXSXMMMMMMMASAMSSSSXSMSSMSAAXAXASXSMXSAAXMXMAXAXSMMMASAMSASMSAAAAMMXMAMMMAMMMMMXAMXAAXMSAMAAAAAXMMSXMMSMXMMMAAAAXSXAMXSXMAXMAMXAAXXMMMSM
MSMXAAMAMXAXMAXXXAXMMAMMMXMAAAMMSMMXSAMAMAMMSXSMMSMMASMMAMAMXMMMMXSMSMSASXSAMAMXXAXMSSSSSMAMAMXMSMMMMXSAMAMAXSASXMMMASMMSASAASXSASMSMMMXSAMX
SMMSSMXAMMAMMMMSSSMAMAMASAMXMMMAAASAMAMAMMXXMASXMAMXMAXSAMMMSMMMSMXXMASAMXMXMSMMSXSAAAXMAMXSSMMMXAAXSASAMXXXXMASAAXSAXAAAASXMAASAMXAAXAAXASM
AAXAAASMXSASASXAAXSXMAXAXASMSMMSSXMASXMASAMMMMMAXAMMXMMXASXAAAAMAASAMAMAXSMSXAAXAAXMMMMSXMAXAAXXSSMSMASAMXXMAMXSMSAMXSMMMMMASMXMAMXSMMMMSAMX
MSMMSMXAASASASMMMMAMSSSMSAMAMXXMAMXAMXSXMMMAAMMAMMSAMXXSXMMSSSMSMSMMMSMAMSAMXSMMMSMMXXMXAMXMSXMAMAMXMAMAAAASXMAMXXMXMMMMXMSXMMMMMMAMMSAAMAMX
XAAXMXMMMMAMXMAAXXXAAXAMAMMSMSMMAXMASXSMSSSSSSMAXSAXAAXMXSXAAMMSXXAMAXMXSMASAMXSXXASMSSSMMSMMMSMSAMMMMSXMSMSAMXSAMXAAAAAAXMAMXAAMMXSAMXSMSMA
SMSXSASAMXMMMSSMXSAMSSXMAMXAAAMMAMSMMASAAMMAXAMXXSAMMSSMASMMXMASXXAMXSXMXMAMAXAXMSAMAMAAMAAMMAXASMSAAAAXAAASAMASAASXSSMXAMSSMSSSXAAMXMXMAMAA
SXMAMXSAMAMAXAAMASXMAAASAXSMSMSMAMAAMAMMMSSSSSXSAMXMXAMMAMAXAMXSMSMMASAMASMSXMMSMMAMSMSMMSSSMMMXMAXXAMXMSMXMMMMSAMXAXAMSSMAMAMAMXMMSAMAMAMAX
XAMAMXMXSASXSSXMASAXMSMSAMSAAAXXSSSSMAXAAMMAAXAASXAXMASMASMSSSXMAAAMASMMAXXAXAAAAAXMAMAAXAAXAASAMXMMXAXXXSAMXAASMMMSMMMAAMAMAMAMXAAXMSMSXSMX
SXMASMAMSAMXMASMMSAMXAMXMASMMXMAMMXXXXSMSSMMMMXMASXSXSXMMSXXMAMMSXSAMXMMASMXMMSSSMSSXSSSMMSSSMSMSAXXMASXMASXSMMSXSXAASMMSSMSXSXSXMSMMAMXMAMS
"""
let rows = input
    .split(separator: "\n")

extension Set {
    func inserting(_ element: Element) -> Self {
        var new = self
        new.insert(element)
        return new
    }
}
let wordSearchMap = Dictionary(
    uniqueKeysWithValues:
        rows
        .enumerated()
        .flatMap({ offsetY, row -> [(Point, Character)] in
            row.enumerated().map { offsetX, char -> (Point, Character) in
                (Point(x: offsetX, y: offsetY), char)
            }
        })
)
enum Xmas: String, CaseIterable, Comparable {
    static func < (lhs: Xmas, rhs: Xmas) -> Bool {
        lhs.index < rhs.index
    }
    
    case x = "X"
    case m = "M"
    case a = "A"
    case s = "S"
    
    init?(rawValue: Character) {
        self.init(rawValue: String(rawValue))
    }
    var description: String {
        rawValue
    }
    var char: Character {
        switch self {
        case .x: return "X"
        case .m: return "M"
        case .a: return "A"
        case .s: return "S"
        }
    }
    var prev: Self? {
        switch self {
        case .x: return .none
        case .m: return .x
        case .a: return .m
        case .s: return .a
        }
    }
    var next: Self? {
        switch self {
        case .x: return .m
        case .m: return .a
        case .a: return .s
        case .s: return .none
        }
    }
    var index: Int {
        switch self {
        case .x: return 1
        case .m: return 2
        case .a: return 3
        case .s: return 4
        }
    }
}
struct WordPart {
    let point: Point
    let char: Xmas
}
extension WordPart {
    func isConnected(to other: Self) -> Bool {
        point.isAdjacent(to: other.point)
        && char.prev == other.char
    }
}
extension WordPart: CustomStringConvertible {
    var description: String {
        "\(char)\(point)"
    }
}
extension WordPart: Equatable, Hashable {}
extension WordPart {
    var neighbours: [Self] {
        point.neighbours
            .compactMap { point -> WordPart? in
                wordSearchMap[point].flatMap { char -> WordPart? in
                    Xmas(rawValue: char).map { xmas in
                        WordPart(point: point, char: xmas)
                    }
                }
            }
    }
    var connectedNeighbours: [Self] {
        neighbours
            .filter { wordPart in
                wordPart.isConnected(to: self)
            }
    }
}
extension WordPart: Comparable {
    static func < (lhs: WordPart, rhs: WordPart) -> Bool {
        lhs.char.index < rhs.char.index
    }
}
extension Array where Element == WordPart {
    var isInline: Bool {
        let points = map(\.point)
        let inits = points.prefix(count - 1)
        return inits.allSatisfy { point in
            points.contains(where: {
                $0.n == point
            })
        }
        ||
        inits.allSatisfy { point in
            points.contains(where: {
                $0.s == point
            })
        }
        ||
        inits.allSatisfy { point in
            points.contains(where: {
                $0.w == point
            })
        }
        ||
        inits.allSatisfy { point in
            points.contains(where: {
                $0.e == point
            })
        }
        ||
        inits.allSatisfy { point in
            points.contains(where: {
                $0.ne == point
            })
        }
        ||
        inits.allSatisfy { point in
            points.contains(where: {
                $0.nw == point
            })
        }
        ||
        inits.allSatisfy { point in
            points.contains(where: {
                $0.se == point
            })
        }
        ||
        inits.allSatisfy { point in
            points.contains(where: {
                $0.sw == point
            })
        }
    }
}
