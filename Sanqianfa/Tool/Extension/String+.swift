//
//  String+.swift
//  Sanqianfa
//
//  Created by 赵翔宇 on 2024/12/21.
//

extension String{
    // 写一个string的扩展，返回随机中文字符串，支持输入长度
    static func randomChineseString(length: Int) -> String {
        var randomChineseString = ""
        for _ in 0..<length {
            let randomHanzi = String(Character(UnicodeScalar(Int.random(in: 0x4E00...0x9FA5))!))
            randomChineseString.append(randomHanzi)
        }
        return randomChineseString
    }
}
