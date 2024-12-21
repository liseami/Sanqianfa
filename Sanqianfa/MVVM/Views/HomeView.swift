//
//  HomeView.swift
//  Sanqianfa
//
//  Created by 赵翔宇 on 2024/12/21.
//

import SwiftUI

struct HomeView: View {
    // MARK: - Main View
    var body: some View {
        ScrollView(.vertical) {
            LazyVStack(alignment: .leading, spacing: 12) {
                // 头部
                headerSection
                // 快速起卦
                quikTestView
                // 他人分享
                cardsSection
            }
            .padding(.horizontal, 16)
        }
    }
    
    // MARK: - Header Section
    private var headerSection: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("三钱法")
                .makeSQText(.SQ.big1b, color: .SQ.f1)
            Text("lvl1 - 今日免费 0 / 1")
                .makeSQText(.SQ.f2, color: .SQ.f2)
                .padding(.bottom, 12)
        }
    }
    
    // MARK: - Cards Section
    private var cardsSection: some View {
        ForEach(0..<12) { _ in
            card()
        }
    }
    
    // MARK: - Quick Test Item View
    private func quickTestItem(color: Color, iconName: String, title: String) -> some View {
        RoundedRectangle(cornerRadius: 24)
            .fill(color)
            .overlay(alignment: .center) {
                VStack(alignment: .center, spacing: 12) {
                    SQDesign.SQICON(name: iconName, size: 44)
                    Text(title)
                        .makeSQText(.SQ.f1b, color: .SQ.f1)
                }
            }
    }
    
    // MARK: - Quick Test View
    private var quikTestView: some View {
        HStack(alignment: .center, spacing: 12) {
            quickTestItem(color: .SQ.green, iconName: "home_today", title: "今日运势")
            quickTestItem(color: .SQ.main, iconName: "home_money", title: "财运速测")
            quickTestItem(color: .SQ.blue, iconName: "home_love", title: "爱情走向")
        }
        .frame(height: 160)
    }
    
    // MARK: - Card View
    private func card() -> some View {
        VStack(alignment: .center, spacing: 12) {
            Text("卦相分享")
                .makeSQText(.SQ.f3, color: .SQ.f2)
                .kerning(3)
            
            Text(String.randomChineseString(length: Int.random(in: 4...24)))
                .multilineTextAlignment(.center)
                .makeSQText(.SQ.big2b, color: .SQ.f1)
            
            Text(String.randomChineseString(length: Int.random(in: 24...120)))
                .makeSQText(.SQ.f2, color: .SQ.f2)
            
            hexagramCircle
        }
        .padding(.all, 24)
        .background(Color.SQ.b2)
        .clipShape(RoundedRectangle(cornerRadius: 24))
    }
    
    // MARK: - Hexagram Circle
    private var hexagramCircle: some View {
        Circle()
            .fill(Color.SQ.main)
            .frame(width: 120, height: 120)
            .overlay(alignment: .center) {
                VStack(alignment: .center, spacing: 4) {
                    ForEach(0..<6) { _ in
                        Rectangle()
                            .frame(width: 32, height: 3)
                    }
                }
            }
    }
}

#Preview {
    ContentView()
        .onAppear {
            MainViewModel.shared.currentTabbar = .home
        }
}
