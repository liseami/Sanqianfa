//
//  LoginView.swift
//  Sanqianfa
//
//  Created by 赵翔宇 on 2025/2/20.
//

import SwiftUI

class LoginViewModel : ObservableObject{
    @Published var loginStep : Int = 0
    var wellComeText : String {
        
        switch loginStep{
        case 0 : return String.randomChineseString(length: 32)
        case 1 : return String.randomChineseString(length: 32)
        case 2 : return String.randomChineseString(length: 32)
        default : return String.randomChineseString(length: 32)
        }
    }
}
struct LoginView: View {
    @ObservedObject var vm : UserManager = .shared
    
    @StateObject var loginVm : LoginViewModel = .init()
    
    var body: some View {
        ZStack(alignment: .center) {
            Color.SQ.b1.ignoresSafeArea()
            
            
            Group{
                switch loginVm.loginStep {
                case 0,1,2 : WellComeView()
                case 3 : PhoneNumberInputView()
                case 4 : SMSCodeInputView()
                default : EmptyView()
                }
            }
            .environmentObject(loginVm)
            
        }
    }
}

#Preview {
    LoginView()
}
