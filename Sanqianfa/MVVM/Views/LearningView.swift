//
//  LearningView.swift
//  Sanqianfa
//
//  Created by 赵翔宇 on 2024/12/21.
//

import SwiftUI

#Preview {
    ContentView()
        .onAppear {
            MainViewModel.shared.currentTabbar = .learn
        }
}

struct LearningView: View {
    var body: some View {
        ScrollView(.vertical) {
            VStack(alignment: .leading, spacing: 24) {
                // 标题
                Text("三钱法")
                    .makeSQText(.SQ.f3, color: .SQ.f2)
                    .kerning(3)
                    .frame(maxWidth: .infinity, alignment: .center)
                
                // 内容部分
                Group {
                    introSection
                    basicPrincipleSection
                    yaoFormationSection
                    practiceStepsSection
                    notesSection
                }
            }
            .padding(.horizontal, 16)
            Spacer().frame(height: 120)
        }
    }
    
    // 各个部分的视图
    private var introSection: some View {
        ContentSection(
            title: "什么是三钱法",
            content: "三钱法是易经预测中的一种简便占卦方法，使用三枚铜钱来演算卦象。这种方法简单易学，是初学者入门易经预测的理想选择。"
        )
    }
    
    private var basicPrincipleSection: some View {
        ContentSection(
            title: "基本原理",
            content: "• 准备工具：三枚相同的铜钱\n• 正面（阳）：数字面\n• 反面（阴）：文字面"
        )
    }
    
    private var yaoFormationSection: some View {
        ContentSection(
            title: "爻的形成",
            content: "• 三枚正面（3阳）：老阳 ○ (9)\n• 二正一反（2阳1阴）：少阳 ⚊ (7)\n• 一正二反（1阳2阴）：少阴 ⚋ (8)\n• 三枚反面（3阴）：老阴 × (6)"
        )
    }
    
    private var practiceStepsSection: some View {
        ContentSection(
            title: "实践步骤",
            content: "1. 净心：保持心静、专注\n2. 持钱：将三枚铜钱捧在手心\n3. 摇钱：默想问题，同时摇动铜钱\n4. 投掷：将钱币抛出\n5. 记录：观察钱币正反面，记录结果\n6. 重复：共进行六次，从下往上记录爻"
        )
    }
    
    private var notesSection: some View {
        ContentSection(
            title: "注意事项",
            content: "• 占卦时应保持虔诚、专注的心态\n• 问题要明确具体\n• 同一个问题短期内不要重复占卦\n• 记录时注意爻的顺序是从下往上"
        )
    }
}

// 内容区块组件
struct ContentSection: View {
    let title: String
    let content: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text(title)
                .makeSQText(.SQ.big3b, color: .SQ.f1)
            Text(content)
                .makeSQText(.SQ.f2, color: .SQ.f2)
                .lineSpacing(6)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(24)
        .background(Color.SQ.b2)
        .clipShape(RoundedRectangle(cornerRadius: 12))
    }
}
