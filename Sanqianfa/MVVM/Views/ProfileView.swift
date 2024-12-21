//
//  ProfileView.swift
//  Sanqianfa
//
//  Created by 赵翔宇 on 2024/12/21.
//

import SwiftUI

struct ProfileView: View {
    @StateObject private var viewModel = ProfileViewModel()
    
    var body: some View {
        ScrollView(.vertical) {
            LazyVStack(alignment: .leading, spacing: 24) {
                Text("我的")
                    .font(.title)
                    .bold()
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.bottom, 12)
                
                ForEach(viewModel.settingGroups) { group in
                    VStack(alignment: .leading, spacing: 5) {
                        // group标题
                        if let title = group.title {
                            Text(title)
                                .makeSQText(.SQ.f3, color: .SQ.f2)
                                .frame(maxWidth:.infinity,alignment: .center)
                                .kerning(3)
                        }
                        
                        ForEach(group.items) { item in
                            SettingRow(item: item)
                        }
                    }
                }
            }
            .padding(.horizontal, 16)
            Spacer().frame(height:120)
        }
    }
}

struct SettingRow: View {
    let item: ProfileSettingItem
    @State private var isOn: Bool = false
    
    var body: some View {
        HStack(alignment: .center, spacing: 12) {
            Text(item.title)
                .makeSQText(.SQ.f1, color: .SQ.f1)
            
            Spacer()
            
            if let rightText = item.rightText {
                Text(rightText)
                    .makeSQText(.SQ.f1, color: .SQ.f2)
            }
            
            if item.hasToggle {
                Toggle("", isOn: $isOn)
                    .labelsHidden()
            }
            
            if item.showArrow {
                Image(systemName: "chevron.forward")
                    .font(.system(size: 12))
                    .foregroundColor(.gray)
            }
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 16)
        .background(Color.SQ.b2)
        .clipShape(RoundedRectangle(cornerRadius: 18))
        .onTapGesture {
            item.action?()
        }
    }
}

#Preview {
    ContentView()
        .onAppear {
            MainViewModel.shared.currentTabbar = .profile
        }
}
