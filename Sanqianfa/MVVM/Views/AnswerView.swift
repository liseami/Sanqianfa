//
//  AnswerView.swift
//  Sanqianfa
//
//  Created by 赵翔宇 on 2025/2/15.
//

import SwiftUI

import EventSource


class AnswerViewModel : ObservableObject{
    @Published var answer : String = ""
    
    struct Response: Codable {
        let content: String
    }
    
    func fetchAnswer(current: String, future: String, question: String) async {
        let parameters = [
            "current": current,
            "future": future,
            "q": question
        ]
        
        guard let url = URL(string: "https://sanqianfa.staging.api.strangerbell.com/api/v1/ai/divination"),
              let jsonData = try? JSONSerialization.data(withJSONObject: parameters) else {
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = jsonData
        
        let eventSource = EventSource()
        let dataTask = await eventSource.dataTask(for: request)
        
        for await event in await dataTask.events() {
            switch event {
            case .open:
                print("✅连接已完成.")
            case .error(let error):
                print("错误:", error.localizedDescription)
            case .event(let event):
                if let data = event.data?.data(using: .utf8),
                   let response = try? JSONDecoder().decode(Response.self, from: data) {
                    self.answer = response.content
                }
            case .closed:
                print("❌连接已关闭")
            }
        }
    }
    
    
}

struct AnswerView: View {
    @ObservedObject var mainViewModel : MainViewModel = .shared
    @StateObject var vm : AnswerViewModel = .init()
    
    var body: some View {
        ZStack{


            Color.SQ.b1.ignoresSafeArea()
            ScrollView(.vertical) {
                Text(LocalizedStringKey(vm.answer))
                    .contentTransition(.numericText())
                    .animation(.smooth, value: vm.answer)
                    .makeSQText(.SQ.f1, color: .SQ.f1)
                    .padding()
                    .background(Color.SQ.b2)
                    .clipShape(RoundedRectangle(cornerRadius: 16))
                    .padding()
            }
            
#if DEBUG
            Button.init {
                Task{
                    await self.vm.fetchAnswer(current: "乾", future: "坤", question: "我这个app能上线吗？")
                }
            } label: {
                Text("发起请求。")
            }
#endif

        }
        .onDisappear(perform: {
            mainViewModel.userInput.removeAll()
            mainViewModel.currentGua.removeAll()
            mainViewModel.futureGua.removeAll()
        })
        .task {
#if DEBUG
            
#else
            await self.vm.fetchAnswer(current: mainViewModel.currentGua, future: mainViewModel.futureGua, question: mainViewModel.userInput)
#endif
        }
    }
}

#Preview {
    AnswerView()
}

