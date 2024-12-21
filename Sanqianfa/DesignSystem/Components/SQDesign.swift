//
//  SQDesgin.swift
//  Sanqianfa
//
//  Created by 赵翔宇 on 2024/12/9.
//

import SwiftUI

enum SQDesign {
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

    struct SQButton: View {
        var body: some View {
            Button.init {} label: {
                Text("自定义按钮")
            }
        }
    }
}

struct SQDesginTestView: View {
    var body: some View {
        VStack(alignment: .center, spacing: 12) {
            SQDesign.SQButton()
            SQDesign.SQICON(systemName: "plus")
            SQDesign.SQICON(name: "tabbar_profile")
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.SQ.b1.ignoresSafeArea())
    }
}

#Preview {
    SQDesginTestView()
}
