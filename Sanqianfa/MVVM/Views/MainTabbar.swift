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
                    Circle()
                        .frame(width: 68, height: 68, alignment: .center)
                        .foregroundColor(.SQ.f1)
                        .padding(.horizontal,12)
                        .overlay(alignment: .center) {
                            Image(systemName: "plus")
                                .resizable()
                                .renderingMode(.template)
                                .bold()
                                .foregroundColor(.SQ.b1)
                                .frame(width: 16, height: 16, alignment: .center)
                                
                        }
                }
            }
        }
        .frame(maxHeight: .infinity, alignment: .bottom)
    }

    
    
    
    
    
    func tab(_ tabbar: MainViewModel.Tabbar) -> some View {
        let selected = tabbar.info.1 == mainViewModel.currentTabbar.info.1
        return Button {
            withAnimation(.smooth) {
                mainViewModel.currentTabbar = tabbar
            }
        } label: {
            VStack(alignment: .center, spacing: 8.1371) {
                Image(tabbar.info.0)
                    .resizable()
                    .renderingMode(.template)
                    .foregroundColor(selected ? .SQ.main : .SQ.f2)
                    .frame(width: 24, height: 24, alignment: .center)
                Text(tabbar.info.1)
                    .makeSQText(.SQ.f3, color: selected ? .SQ.main : .SQ.f2)
            }
            .frame(maxWidth: .infinity)
        }
    }
}

#Preview {
    ZStack(alignment: .center) {
        Color.SQ.b1.ignoresSafeArea()
        MainTabbar()
    }
}
