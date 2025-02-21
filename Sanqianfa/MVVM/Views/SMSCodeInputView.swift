//
//  SMSCodeInputView.swift
//  Sanqianfa
//
//  Created by 赵翔宇 on 2025/2/20.
//

import SwiftUI

struct SMSCodeInputView: View {
    @ObservedObject var vm : UserManager = .shared
    @EnvironmentObject var loginVm : LoginViewModel
    var body: some View {
        VStack (alignment: .leading,  spacing:68){
            Spacer()
            Text("请输入你收到的验证码")
                .makeSQText(.SQ.big3, color: .SQ.f1)
            TextField("验证码", text: $vm.smsCodeInput)
                .multilineTextAlignment(.center)
                .makeSQText(.SQ.big1b, color: .SQ.f1)
                .keyboardType(.numberPad)
                .colorScheme(.dark)
                .tint(Color.SQ.f1)
                .padding()
                .background(Color.SQ.b2)
                .clipShape(RoundedRectangle(cornerRadius: 12))
            SQDesign.SmallBtn(text: "登录") {
                await vm.login()
            }
            .frame(maxWidth:.infinity,alignment: .center)
            Spacer()
        }
        .padding(.all,24)
        
    }
}

#Preview {
    ZStack {
        Color.SQ.b1.ignoresSafeArea()
        SMSCodeInputView()
            .environmentObject(LoginViewModel())
    }
}
