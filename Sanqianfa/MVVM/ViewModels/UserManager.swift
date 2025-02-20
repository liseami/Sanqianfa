//
//  UserManager.swift
//  Sanqianfa
//
//  Created by 赵翔宇 on 2024/12/9.
//

import SwiftUI

class UserManager  : ObservableObject{
    static let shared : UserManager = .init()
    @Published var userLogged : Bool = false
    @Published var phoneNumberInput : String = ""
    @Published var smsCodeInput : String = ""
    
    
    // 发送短信验证码
    func getSMSCode() {
        
    }
    
    // 登录
    func login() {
        userLogged = true
    }
    
}

