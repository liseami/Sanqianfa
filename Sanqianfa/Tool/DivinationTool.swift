//
//  DivinationTool.swift
//  Sanqianfa
//
//  Created by 赵翔宇 on 2024/12/23.
//

import SwiftUI

/// 爻的状态枚举
enum Yao: String {
    case oldYang = "老阳"
    case oldYin = "老阴"
    case youngYang = "少阳"
    case youngYin = "少阴"
    case unknow = "未定"
    var id: UUID {
        UUID()
    }
}

class DivinationTool{
    /// 根据二进制字符串获取卦象
    static func getHexagram(from binary: String) -> Hexagram? {
        return Hexagram(rawValue: binary)
    }
    
    /// 根据爻状态数组获取卦象
    /// - Parameter yaoStates: 爻状态数组，从下往上
    /// - Returns: 对应的卦象
    static func getHexagram(from yaoStates: [Yao]) -> Hexagram? {
        guard yaoStates.count == 6 else { return nil }
        let binary = yaoStates.map { yao in
            switch yao {
            case .oldYang, .youngYang: return "1"  // 老阳和少阳都是阳爻
            case .oldYin, .youngYin: return "0"    // 老阴和少阴都是阴爻
            case .unknow: return "0"               // 未知状态默认为阴
            }
        }.joined()
        return getHexagram(from: binary)
    }
    
    /// 获取变卦
    /// - Parameter yaoResults: 每一爻的状态数组，从下往上
    /// - Returns: 变卦后的卦象
    static func getChangedHexagram(from yaoResults: [Yao]) -> Hexagram? {
        guard yaoResults.count == 6 else { return nil }
        let binary = yaoResults.map { yao in
            switch yao {
            case .oldYang: return "0" // 老阳变少阴
            case .oldYin: return "1"  // 老阴变少阳
            case .youngYang: return "1" // 少阳不变
            case .youngYin: return "0"  // 少阴不变
            case .unknow: return "0"    // 未知状态默认为0
            }
        }.joined()
        return getHexagram(from: binary)
    }
    
    /// 根据三枚铜钱的阳数获取爻的状态
    /// - Parameter yangCount: 阳的数量 (0-3)
    /// - Returns: 对应的爻状态
    static func getYaoState(from yangCount: Int) -> Yao {
        switch yangCount {
        case 3: return .oldYang   // 三阳为老阳
        case 2: return .youngYang // 二阳为少阳
        case 1: return .youngYin  // 一阳为少阴
        case 0: return .oldYin    // 零阳为老阴
        default: return .unknow
        }
    }
}

// 六十四卦枚举
enum Hexagram: String, CaseIterable {
    case 乾 = "111111"
    case 坤 = "000000"
    case 屯 = "010001"
    case 蒙 = "100010"
    case 需 = "010111"
    case 讼 = "111010"
    case 师 = "000010"
    case 比 = "010000"
    case 小畜 = "110111"
    case 履 = "111011"
    case 泰 = "000111"
    case 否 = "111000"
    case 同人 = "111101"
    case 大有 = "101111"
    case 谦 = "000100"
    case 豫 = "001000"
    case 随 = "011001"
    case 蛊 = "100110"
    case 临 = "000011"
    case 观 = "110000"
    case 噬嗑 = "101001"
    case 贲 = "100101"
    case 剥 = "000001"
    case 复 = "100000"
    case 无妄 = "111001"
    case 大畜 = "100111"
    case 颐 = "100001"
    case 大过 = "011110"
    case 坎 = "010010"
    case 离 = "101101"
    case 咸 = "011100"
    case 恒 = "001110"
    case 遁 = "111100"
    case 大壮 = "001111"
    case 晋 = "101000"
    case 明夷 = "000101"
    case 家人 = "101011"
    case 睽 = "110101"
    case 蹇 = "010100"
    case 解 = "001010"
    case 损 = "100011"
    case 益 = "110001"
    case 夬 = "111110"
    case 姤 = "011111"
    case 萃 = "000110"
    case 升 = "011000"
    case 困 = "010110"
    case 井 = "011010"
    case 革 = "101110"
    case 鼎 = "011101"
    case 震 = "001001"
    case 艮 = "100100"
    case 渐 = "110100"
    case 归妹 = "001011"
    case 丰 = "101100"
    case 旅 = "001101"
    case 巽 = "110110"
    case 兑 = "011011"
    case 涣 = "110010"
    case 节 = "010011"
    case 中孚 = "110011"
    case 小过 = "001100"
    case 既济 = "010101"
    case 未济 = "101010"

    var binary: [Bool] {
        self.rawValue.compactMap { $0.wholeNumberValue }.map { $0 == 1 }
    }

    var name: String {
        String(describing: self)
    }
}
