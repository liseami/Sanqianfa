//
//  ContentView.swift
//  Sanqianfa
//
//  Created by 赵翔宇 on 2024/12/9.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var mainViewModel : MainViewModel = .shared
    var body: some View {
        NavigationStack {
            ZStack {
                Color.SQ.b1.ignoresSafeArea()
                Group{
                    switch mainViewModel.currentTabbar {
                    case .home:
                        Text("主页")
                    case .things:
                        Text("历史")
                    case .learn:
                        Text("原理")
                    case .profile:
                        Text("我的")
                    }
                }
                .makeSQText(.SQ.big3b, color: .SQ.f1)
                MainTabbar()
            }
        }
    }
}

#Preview {
    ContentView()
}
