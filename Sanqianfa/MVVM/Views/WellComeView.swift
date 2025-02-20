//
//  WellComeView_1.swift
//  Sanqianfa
//
//  Created by 赵翔宇 on 2025/2/20.
//

import SwiftUI

struct WellComeView: View {
    @EnvironmentObject var vm: LoginViewModel
    
    var body: some View {
        VStack(spacing: 48, content: {
            Spacer()
            Image("wellcome_\(vm.loginStep)")
                .resizable()
                .scaledToFit()
                .padding(.all, 24)
            Text(vm.wellComeText)
                .kerning(5)
                .multilineTextAlignment(.center)
                .makeSQText(.SQ.f1, color: .SQ.f1)
            Spacer()
        })
        .padding(.all, 48)
        .overlay(alignment: .bottom) {
            Button {
                vm.loginStep += 1
            } label: {
                Capsule().frame(height: 44)
                    .foregroundStyle(Color.SQ.main)
                    .overlay(alignment: .center) {
                        SQDesign.SQICON(systemName: "chevron.right",size: 16)
                    }
                    .frame(width: 180)
                    .padding(.bottom,44)
            }

        }
    }
}

#Preview {
    LoginView()
}
