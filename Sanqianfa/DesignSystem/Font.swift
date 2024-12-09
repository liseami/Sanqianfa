//
//  Font.swift
//  Sanqianfa
//
//  Created by 赵翔宇 on 2024/12/9.
//

import SwiftUI

struct FontTestView: View {
    let fontTests: [(font: Font, color: Color?)] = [
        (.SQ.big1b, nil),
        (.SQ.big1, nil),
        (.SQ.big2b, nil),
        (.SQ.big2, nil),
        (.SQ.big3b, nil),
        (.SQ.big3, nil),
        (.SQ.f1b, nil),
        (.SQ.f1, nil),
        (.SQ.f2b, nil),
        (.SQ.f2, nil),
        (.SQ.f3, .SQ.f3),
        (.SQ.f3b, .SQ.f3)
    ]
    
    var body: some View {
        VStack(alignment: .center, spacing: 12) {
            ForEach(fontTests.indices, id: \.self) { index in
                let test = fontTests[index]
                if let color = test.color {
                    Text("Hello, World!")
                        .makeSQText(test.font, color: color)
                } else {
                    Text("Hello, World!")
                        .font(test.font)
                }
            }
        }
    }
}

#Preview {
    FontTestView()
}

extension Font {
    enum SQ {
        static let big1: Font = .system(size: 32)
        static let big1b: Font = .system(size: 32).bold()
        static let big2: Font = .system(size: 27)
        static let big2b: Font = .system(size: 27).bold()
        static let big3: Font = .system(size: 24)
        static let big3b: Font = .system(size: 24).bold()
        static let f1: Font = .system(size: 17)
        static let f1b: Font = .system(size: 17).bold()
        static let f2: Font = .system(size: 15)
        static let f2b: Font = .system(size: 15).bold()
        static let f3: Font = .system(size: 13)
        static let f3b: Font = .system(size: 13).bold()
    }
}
