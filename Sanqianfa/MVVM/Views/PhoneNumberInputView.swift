//
//  PhoneNumberInputView.swift
//  Sanqianfa
//
//  Created by 赵翔宇 on 2025/2/20.
//

import SwiftUI

struct PhoneNumberInputView: View {
    @ObservedObject var vm : UserManager = .shared
    @EnvironmentObject var loginVm : LoginViewModel
    var body: some View {
        VStack (alignment: .leading,  spacing:68){
            Spacer()
            Text("请输入11位手机号码")
                .makeSQText(.SQ.big3, color: .SQ.f1)
            TextField("手机号", text: $vm.phoneNumberInput)
                .colorScheme(.dark)
                .tint(Color.SQ.f1)
                .foregroundStyle(Color.SQ.f1)
                .padding()
                .background(Color.SQ.b2)
                .clipShape(RoundedRectangle(cornerRadius: 12))
            SQDesign.SmallBtn(text: "获取验证码") {
                let isOK = await vm.getSMSCode()
                if isOK{
                    loginVm.loginStep += 1
                }else{}
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
        PhoneNumberInputView()
            .environmentObject(LoginViewModel())
    }
}
