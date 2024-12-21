//
//  MainTabbar.swift
//  Sanqianfa
//
//  Created by 赵翔宇 on 2024/12/9.
//

import SwiftUI

struct MainTabbar: View {
    @ObservedObject var mainViewModel: MainViewModel = .shared
    var body: some View {
        HStack(alignment: .center, spacing: 0) {
            ForEach(mainViewModel.allTabbar, id: \.info.1) { tabbar in
                tab(tabbar)
                if tabbar == .things {
                    addBtn()
                }
            }
        }
        .padding(.top, 12)
        .background(bottomGradientView)
        .frame(maxHeight: .infinity, alignment: .bottom)
    }

    // MARK: - Bottom Gradient View
    private var bottomGradientView: some View {
        ZStack {
            Rectangle()
                .fill(.ultraThinMaterial)
                .colorScheme(.dark)
                .mask(
                    VStack(spacing: 0) {
                        LinearGradient(colors: [.clear, .black], startPoint: .top, endPoint: .bottom)
                        Rectangle()
                    }
                )
                .frame(height: UIScreen.main.bounds.height * 0.42)
        }
    }

    
    func addBtn() -> some View {
        Circle()
            .frame(width: 68, height: 68, alignment: .center)
            .foregroundColor(.SQ.f1)
            .padding(.horizontal, 12)
            .overlay(alignment: .center) {
                SQDesign.SQICON(systemName: "plus",size: 16, color: .SQ.b1)
            }
    }

    func tab(_ tabbar: MainViewModel.Tabbar) -> some View {
        let selected = tabbar.info.1 == mainViewModel.currentTabbar.info.1
        return Button {
            withAnimation(.smooth) {
                mainViewModel.currentTabbar = tabbar
            }
        } label: {
            VStack(alignment: .center, spacing: 8.1371) {
                SQDesign.SQICON(name:tabbar.info.0,color: selected ? .SQ.main : .SQ.f2)
                Text(tabbar.info.1)
                    .makeSQText(.SQ.f3, color: selected ? .SQ.main : .SQ.f2)
            }
            .frame(maxWidth: .infinity)
        }
    }
}

#Preview {
    ContentView()
        .onAppear {
            MainViewModel.shared.currentTabbar = .things
        }
}
