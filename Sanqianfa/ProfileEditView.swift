//
//  ProfileEditView.swift
//  Sanqianfa
//
//  Created by 赵翔宇 on 2025/3/9.
//

import SwiftUI

struct ProfileEditView: View {
    @State var username: String
    init(username: String) {
        self._username = State(initialValue: username)
    }

    @MainActor
    func updateUserName() async {
        let t = UserAPI.update(username: self.username)
        let r = await Networking.request_async(t)
        if r.is200Ok {
            MainViewModel.shared.back()
            
        }
    }

    var body: some View {
        VStack {
            HStack(alignment: .center) {
                Text("用户名")
                Spacer()
                TextField(text: $username) {}
                    .multilineTextAlignment(.trailing)
            }
            .padding(.all, 16)
            .background(Color.black.opacity(0.03))
            .clipShape(RoundedRectangle(cornerRadius: 12))
            Spacer()
        }
        .padding()
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Text("确认")
                    .onTapGesture {
                        Task{
                            await self.updateUserName()
                        }
                    }
            }
        }
    }
}

#Preview {
    NavigationView {
        ProfileEditView(username: "赵纯想")
    }
}
