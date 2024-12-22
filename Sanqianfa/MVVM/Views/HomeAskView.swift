//
//  HomeAskView.swift
//  Sanqianfa
//
//  Created by 赵翔宇 on 2024/12/22.
//

import SwiftUI

struct HomeAskView: View {
    @ObservedObject var mainViewModel: MainViewModel = .shared
    @State var show: Bool = false

    var body: some View {
        ZStack(alignment: .center) {
            if show {
                Rectangle()
                    .fill(.ultraThinMaterial)
                    .colorScheme(.dark)
                    .ignoresSafeArea()
                    .transition(.opacity.animation(.easeInOut(duration: 1)))
                    .onTapGesture {
                        mainViewModel.showInputCard = false
                    }
            }

            if show {
                VStack(alignment: .center, spacing: 12,
                       content: {
                           VStack(alignment: .center, spacing: 12) {
                               Text("输入当下的疑惑：")
                                   .kerning(3)
                                   .makeSQText(.SQ.f3, color: .SQ.f1)
                               TextEditor(text: $mainViewModel.userInput)
                                   .frame(height: 120)
                                   .scrollContentBackground(.hidden)
                                   .makeSQText(.SQ.f1, color: .SQ.f1)
                                   .accentColor(.SQ.f1)

                               SQDesign.SmallBtn(text: "起卦") {
                                   show = false
                                   DispatchQueue.main.asyncAfter(deadline: .now() + 0.8) {
                                       mainViewModel.showInputCard = false
                                   }
                               }
                           }
                           .padding(.bottom, 32)
                           .padding(.top, 48)
                           .padding(.horizontal, 24)
                           .background(Color.SQ.b2)
                           .clipShape(RoundedRectangle(cornerRadius: 18))
                           Text("心诚则灵")
                               .kerning(3)
                               .makeSQText(.SQ.f3, color: .SQ.f1)
                       })
                       .padding(.horizontal, 24)
                       .transition(.move(edge: .bottom).combined(with: .opacity).animation(.easeInOut(duration: 0.4)))
            }
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                withAnimation {
                    show = true
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
