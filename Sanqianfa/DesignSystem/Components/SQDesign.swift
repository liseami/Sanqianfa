//
//  SQDesgin.swift
//  Sanqianfa
//
//  Created by 赵翔宇 on 2024/12/9.
//

import SwiftUI

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
