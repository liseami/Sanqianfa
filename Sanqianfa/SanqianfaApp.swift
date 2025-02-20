//
//  SanqianfaApp.swift
//  Sanqianfa
//
//  Created by 赵翔宇 on 2024/12/9.
//

import SwiftUI

@main
struct SanqianfaApp: App {
    @ObservedObject var userManager : UserManager = .shared
    var body: some Scene {
        WindowGroup {
            if userManager.userLogged {
                ContentView()
            }else{
               LoginView()
            }
        }
    }
}
