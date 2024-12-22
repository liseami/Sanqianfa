//
//  SQDesgin.swift
//  Sanqianfa
//
//  Created by 赵翔宇 on 2024/12/9.
//

import SwiftUI

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

enum SQDesign {
    struct YIN: View {
        var body: some View {
            HStack(alignment: .center, spacing: 6) {
                Rectangle()
                Rectangle()
            }
            .frame(width: 36, height: 3)
            .foregroundColor(.SQ.f1)
        }
    }

    struct YANG: View {
        var body: some View {
            Rectangle()
                .frame(width: 36, height: 3)
                .foregroundColor(.SQ.f1)
        }
    }

    struct GUA: View {
        let binary: [Bool]
        let name: String

        // 通过六十四卦枚举初始化
        init(_ hexagram: Hexagram) {
            self.binary = hexagram.binary
            self.name = hexagram.name
        }

        // 保留原有的二进制字符串初始化方法
        init(_ binaryString: String, name: String = "") {
            self.binary = binaryString
                .compactMap { $0.wholeNumberValue }
                .map { $0 == 1 }
            self.name = name
        }

        init(binary: [Bool], name: String = "") {
            assert(binary.count == 6, "卦象必须包含6个爻")
            self.binary = binary
            self.name = name
        }

        var body: some View {
            VStack(alignment: .center, spacing: 3) {
                // 从下到上渲染爻
                ForEach(Array(binary.enumerated()).reversed(), id: \.offset) { _, isYang in
                    if isYang {
                        YANG()
                    } else {
                        YIN()
                    }
                }

                if !name.isEmpty {
                    Text(name)
                        .font(.caption)
                        .foregroundColor(.SQ.f1)
                }
            }
        }
    }

    struct SmallBtn: View {
        let action: () -> Void
        let text: String
        init(text: String, action: @escaping () -> Void) {
            self.text = text
            self.action = action
        }

        var body: some View {
            SQDesign.SQButton {
                action()
            } label: {
                Text(text)
                    .makeSQText(.SQ.f1b, color: .SQ.f1)
                    .padding(12)
                    .padding(.horizontal, 48)
                    .background(Color.SQ.main)
                    .clipShape(Capsule())
            }
        }
    }

    struct SQICON: View {
        let name: String?
        let systemName: String?
        let size: CGFloat
        let color: Color

        init(systemName: String, size: CGFloat = 24, color: Color = .SQ.f1) {
            self.name = nil
            self.systemName = systemName
            self.size = size
            self.color = color
        }

        init(name: String, size: CGFloat = 24, color: Color = .SQ.f1) {
            self.name = name
            self.systemName = nil
            self.size = size
            self.color = color
        }

        var body: some View {
            Group {
                // 系统图标
                if let systemName {
                    Image(systemName: systemName)
                        .resizable()
                        .renderingMode(.template)
                }

                if let name {
                    Image(name)
                        .resizable()
                        .renderingMode(.template)
                }
            }
            .scaledToFit()
            .frame(width: size, height: size)
            .foregroundColor(color)
        }
    }

    struct SQButton<Content: View>: View {
        let action: () -> Void
        let label: () -> Content
        init(action: @escaping () -> Void, label: @escaping () -> Content) {
            self.action = action
            self.label = label
        }

        var body: some View {
            Button.init {
                action()
            } label: {
                label()
            }

        }
    }
}

struct SQDesginTestView: View {
    // 定义网格布局
    let columns = [
        GridItem(.adaptive(minimum: 60, maximum: 80), spacing: 12),
    ]

    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                // 基础组件展示
                Group {
                    Text("基础组件")
                        .font(.headline)

                    HStack(spacing: 20) {
                        SQDesign.YIN()
                        SQDesign.YANG()
                    }

                    HStack(spacing: 20) {
                        SQDesign.SQICON(systemName: "plus")
                        SQDesign.SQICON(name: "tabbar_profile")
                    }
                }

                // 六十四卦展示
                Group {
                    Text("六十四卦")
                        .font(.headline)

                    LazyVGrid(columns: columns, spacing: 16) {
                        ForEach(Hexagram.allCases, id: \.self) { hexagram in
                            SQDesign.GUA(hexagram)
                        }
                    }
                    .padding(.horizontal)
                }
            }
            .padding()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.SQ.b1.ignoresSafeArea())
    }
}

#Preview {
    SQDesginTestView()
}
