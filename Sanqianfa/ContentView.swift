//
//  ContentView.swift
//  Sanqianfa
//
//  Created by 赵翔宇 on 2024/12/9.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var mainViewModel: MainViewModel = .shared
    var body: some View {
        NavigationStack {
            ZStack {
                Color.SQ.b1.ignoresSafeArea()
                Group {
                    switch mainViewModel.currentTabbar {
                    case .home:
                        HomeView()
                    case .things:
                        HistrotyView()
                    case .learn:
                        LearningView()
                    case .profile:
                        ProfileView()
                    }
                }
                .makeSQText(.SQ.big3b, color: .SQ.f1)
                MainTabbar()

                if mainViewModel.showInputCard {
                    HomeAskView()
                }
            }
            .fullScreenCover(isPresented: $mainViewModel.showDivinationView) {
                DivinationView()
            }
        }
    }

    
}

#Preview {
    ContentView()
}
