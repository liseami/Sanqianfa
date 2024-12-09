//
//  SQDesgin.swift
//  Sanqianfa
//
//  Created by 赵翔宇 on 2024/12/9.
//

import SwiftUI


enum SQDesign{
    struct SQButton : View {
        var body: some View {
            Button.init {
                
            } label: {
                Text("自定义按钮")
            }

        }
    }
}

struct SQDesginTestView: View {
    var body: some View {
        VStack(alignment: .center, spacing: 12) {
            SQDesign.SQButton.init()
        }
    }
}

#Preview {
    SQDesginTestView()
}
