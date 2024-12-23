//
//  DivinationView.swift
//  Sanqianfa
//
//  Created by 赵翔宇 on 2024/12/23.

import SwiftUI

struct DivinationView: View {
    @State var rotations: [CGFloat] = [0, 0, 0]
    @State var coinFace: [Bool] = [true, true, true]
    @State var yangCount: [Int] = [-1, -1, -1, -1, -1, -1]
    @State var divinationIndex: Int = 0
    @State var btnLock: Bool = false
    @State var yao: [Yao] = []
    @State var gua: Hexagram?
    @State var bianGua: Hexagram?
    @State var showGua: Bool = false
    let duration : Double = 0.1
    
    var isOver: Bool {
        divinationIndex == 6
    }

    var body: some View {
        ZStack {
            Color.SQ.b1.ignoresSafeArea()
            VStack(alignment: .center, spacing: 12) {
                if !isOver {
                    coins
                } else {
                    Text(MainViewModel.shared.userInput).makeSQText(.SQ.big1b, color: .SQ.f1)
                }
                Spacer()
                result
                Spacer()
                SQDesign.SmallBtn(text: isOver ? "解卦" : "起卦\(divinationIndex + 1) / 6") {
                    if isOver {
                    } else {
                        if btnLock {
                        } else {
                            divination()
                        }
                    }
                }
            }
            .padding(.all, 24)
        }
    }

    @ViewBuilder
    var result: some View {
        if isOver {
            if showGua {
                HStack(alignment: .center, spacing: 12) {
                    VStack(alignment: .center, spacing: 12) {
                        Text("此刻")
                            .scaleEffect(0.6)
                        SQDesign.GUA(self.gua!)
                    }
                    VStack(alignment: .center, spacing: 12) {
                        Text("未来")
                            .scaleEffect(0.6)
                        SQDesign.GUA(self.bianGua!)
                    }
                }
                .makeSQText(.SQ.f1, color: .SQ.main)
                .scaleEffect(3)
                .transition(.scale.combined(with: .blurReplace))
            }
        } else {
            VStack(alignment: .center, spacing: 12) {
                ForEach(Array(0 ..< 6).reversed(), id: \.self) { index in
                    let yangCount = yangCount[index]
                    HStack(alignment: .center, spacing: 12) {
                        switch yangCount {
                        case 3: SQDesign.YANG()
                        case 2: SQDesign.YANG()
                        case 1: SQDesign.YIN()
                        case 0: SQDesign.YIN()
                        default: EmptyView()
                        }
                        switch yangCount {
                        case 3: Text("老阳")
                        case 2: Text("少阳")
                        case 1: Text("少阴")
                        case 0: Text("老阴")
                        default: Text("未定")
                        }
                    }
                    .makeSQText(.SQ.f3, color: .SQ.f2)
                }
            }
            .animation(.smooth, value: isOver)
        }
    }

    var coins: some View {
        HStack(alignment: .center, spacing: 12) {
            ForEach(0 ..< 3) { index in
                let rotation = self.rotations[index]
                let face = self.coinFace[index]

                Circle()
                    .foregroundColor(face ? .SQ.main : .SQ.blue)
                    .overlay {
                        if face {
                            SQDesign.YANG()
                        } else {
                            SQDesign.YIN()
                        }
                    }
                    .rotation3DEffect(.degrees(rotation), axis: (x: 0, y: 1, z: 0))
            }
        }
    }

    func divination() {
        btnLock = true
        
        withAnimation(.easeInOut(duration: duration)) {
            for i in 0 ..< 3 {
                let randomr = Int.random(in: 1 ... 120)
                self.rotations[i] = CGFloat(randomr * 360)
            }
//            self.rotations = self.rotations.map({ _ in
//                let randomr = Int.random(in: 1 ... 120)
//                return CGFloat(randomr * 360)
//            })
        }

        DispatchQueue.main.asyncAfter(deadline: .now() + duration) {
            withAnimation {
                // 确认随机结果
                for i in 0 ..< 3 {
                    self.coinFace[i] = Bool.random()
                }

                // 根据结果，由下向上，确定1爻
                var yangCount = 0
                for face in coinFace {
                    if face == true {
                        yangCount += 1
                    }
                }
                //
                //            var yangCount1 = coinFace.filter { $0 }.count
                //            print(yangCount)

                self.yangCount[divinationIndex] = yangCount
                //            print(yangCount)
                divinationIndex += 1
                if isOver {
                    self.yao = self.yangCount.map { yangCount in
                        DivinationTool.getYaoState(from: yangCount)
                    }
                    self.gua = DivinationTool.getHexagram(from: self.yao)
                    self.bianGua = DivinationTool.getChangedHexagram(from: self.yao)
                    print(gua)
                    print(bianGua)
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                        showGua = true
                    }
                }
                btnLock = false
            }
        }
    }
}

#Preview {
    DivinationView()
        .onAppear {
            MainViewModel.shared.userInput = "我今年的桃花运怎么样？"
        }
}
