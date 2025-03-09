//
//  MainViewModel.swift
//  Sanqianfa
//
//  Created by 赵翔宇 on 2024/12/9.
//

import SwiftUI

class MainViewModel: ObservableObject {
    static let shared: MainViewModel = .init()
    @Published var currentTabbar: Tabbar = .home
    @Published var showInputCard: Bool = false
    // 用户问题
    @Published var userInput: String = ""
    // 当前卦象
    @Published var currentGua: String = ""
    // 未来卦象（变卦）
    @Published var futureGua: String = ""
    @Published var showDivinationView: Bool = false
    @Published var showAnswerView: Bool = false
    let allTabbar: [Tabbar] = [.home, .things, .learn, .profile]
    enum Tabbar: CaseIterable {
        case home, things, learn, profile
        var info: (String, String) {
            switch self {
            case .home:
                return ("tabbar_home", "起卦")
            case .things:
                return ("tabbar_history", "历史")
            case .learn:
                return ("tabbar_learn", "原理")
            case .profile:
                return ("tabbar_profile", "我的")
            }
        }
    }

    @Published var navigationPath: NavigationPath = .init()
    func pushTo(_ path : AppPagePath) {
        self.navigationPath.append(path)
    }
    
    func back() {
        self.navigationPath.removeLast()
    }
}

public enum AppPagePath {
    case subView1
    case subView2
    case editProfileView
    case x1
    case x2
}
