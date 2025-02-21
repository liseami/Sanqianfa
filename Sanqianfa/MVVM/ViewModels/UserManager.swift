//
//  UserManager.swift
//  Sanqianfa
//
//  Created by 赵翔宇 on 2024/12/9.
//

import SwiftUI

class UserManager: ObservableObject {
    static let shared: UserManager = .init()
    @Published var userLogged: Bool = false
    @Published var phoneNumberInput: String = ""
    @Published var smsCodeInput: String = ""

    var token : String = ""
    init() {
        
        if UserDefaults.standard.string(forKey: "local_token") != nil {
            self.token = UserDefaults.standard.string(forKey: "local_token")!
            self.userLogged = true
        }
    }
    
    @MainActor
    func logout () {
        UserDefaults.standard.set(nil, forKey: "local_token")
        self.userLogged = false
    }

    // 发送短信验证码
    func getSMSCode() async -> Bool {
        let t = LoginAPI.request_sms_code(phone: phoneNumberInput)
        let r = await Networking.request_async(t)
        if r.is200Ok {
            return true
        } else {
            return false
        }
    }

    // 登录
    @MainActor
    func login() async {
        let t = LoginAPI.signup_and_login_with_mobile_phone_and_sms_code(phone_number: phoneNumberInput, sms_code: smsCodeInput)
        let r = await Networking.request_async(t)
        if r.is200Ok {
            if let token = r.dataJson?["access_token"].string {
                UserDefaults.standard.set(token, forKey: "local_token")
                userLogged = true
            }
        } else {
            
        }
    }
}
