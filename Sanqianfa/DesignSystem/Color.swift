//
//  Color.swift
//  Sanqianfa
//
//  Created by 赵翔宇 on 2024/12/9.
//

import SwiftUI


struct ColorTestView: View {
    let colors: [(color: Color, name: String)] = [
        (.SQ.f1, "前景色1"),
        (.SQ.f2, "前景色2"), 
        (.SQ.f3, "前景色3"),
        (.SQ.b1, "背景色1"),
        (.SQ.b2, "背景色2"),
        (.SQ.b3, "背景色3")
    ]
    
    var body: some View {
        VStack(alignment: .center, spacing: 12) {
            ForEach(colors.indices, id: \.self) { index in
                Rectangle()
                    .frame(width: 132, height: 132, alignment: .center)
                    .foregroundColor(colors[index].color)
            }
        }
    }
}

#Preview {
    ColorTestView()
}

extension Color {
    enum SQ {
        /// 前景色1号色
        static let f1 = Color(hex: "E2DDD3")
        /// 前景色2号色
        static let f2 = Color(hex: "7D7A7D")
        /// 前景色3号色
        static let f3 = Color(hex: "817E81")
        /// 背景色1号色
        static let b1 = Color(hex: "030003")
        /// 背景色2号色
        static let b2 = Color(hex: "191619")
        /// 背景色3号色
        static let b3 = Color(hex: "191619")
        static let main = Color.init(hex: "B44E4E")
    }
}

extension Color {
    /// 使用十六进制字符串初始化 Color
    /// - Parameter hex: 十六进制颜色字符串，支持 "FFFFFF" 或 "#FFFFFF" 格式
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0

        Scanner(string: hex).scanHexInt64(&int)
        let r, g, b: Double

        switch hex.count {
        case 3: // RGB (12-bit)
            r = Double((int >> 8) & 0xF) / 15.0
            g = Double((int >> 4) & 0xF) / 15.0
            b = Double(int & 0xF) / 15.0
        case 6: // RGB (24-bit)
            r = Double((int >> 16) & 0xFF) / 255.0
            g = Double((int >> 8) & 0xFF) / 255.0
            b = Double(int & 0xFF) / 255.0
        default:
            r = 0
            g = 0
            b = 0
        }

        self.init(red: r, green: g, blue: b)
    }
}
