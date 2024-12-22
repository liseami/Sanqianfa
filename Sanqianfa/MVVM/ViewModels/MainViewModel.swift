//
//  MainViewModel.swift
//  Sanqianfa
//
//  Created by 赵翔宇 on 2024/12/9.
//

import SwiftUI

class MainViewModel: ObservableObject {
    static let shared : MainViewModel = .init()
    @Published var currentTabbar: Tabbar = .home
    @Published var showInputCard : Bool = false
    @Published var userInput : String = ""
    let allTabbar : [Tabbar] = [.home,.things,.learn,.profile]
    enum Tabbar : CaseIterable {
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
}
