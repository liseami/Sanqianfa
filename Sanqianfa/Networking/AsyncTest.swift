//
//  SC.swift
//  Sanqianfa
//
//  Created by 赵翔宇 on 2025/2/21.
//

import SwiftUI

struct AsyncTest: View {
    @State var isLoading : Bool = false
    var body: some View {
        ScrollView(.vertical) {
            VStack {
                ForEach(0 ..< 12, id: \.self) { _ in
                    Text(String.randomChineseString(length: 12))
                    
                }
                if isLoading{
                    ProgressView()
                        .scaleEffect(3)
                }
                Button.init {
                    print("开始网络请求")
                    isLoading = true
                    getData()
                    isLoading = false
//                    DispatchQueue.global().async {
//                        
//                        DispatchQueue.main.async {
//                            print("网络请求完毕")
//                            isLoading = false
//                        }
//                    }
                } label: {
                    Text("获取数据")
                }

            }
        }
    }
    
    func getData() {
        sleep(3)
    }
    // UI的绘制在主线程上执行
    // async await
    //
}

#Preview {
    AsyncTest()
}
