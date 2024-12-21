//
//  HistrotyView.swift
//  Sanqianfa
//
//  Created by 赵翔宇 on 2024/12/21.
//

import SwiftUI

struct HistrotyView: View {
    var body: some View {
        ScrollView(.vertical) {
            Text("起卦历史")
                .makeSQText(.SQ.f3, color: .SQ.f2)
                .kerning(3)
            LazyVStack(alignment: .leading, spacing: 3) {
                ForEach(0 ..< 12) { item in
                    row()
                }
            }
            .padding(.horizontal,16)
        }
    }
    
    // 起卦历史记录
    func row() -> some View {
        VStack(alignment: .leading,spacing:12){
            Text(String.randomChineseString(length: Int.random(in: 4...12)))
                .makeSQText(.SQ.big3b, color: .SQ.f1)
            Text(String.randomChineseString(length: Int.random(in: 12...32)))
                .lineLimit(2)
                .makeSQText(.SQ.f2, color: .SQ.f2)
        }
        .frame(maxWidth:.infinity,alignment: .leading)
        .padding(24)
        .background(Color.SQ.b2)
        .clipShape(RoundedRectangle(cornerRadius: 12))
    }
}

#Preview {
    ContentView()
        .onAppear {
            MainViewModel.shared.currentTabbar = .things
        }
}
