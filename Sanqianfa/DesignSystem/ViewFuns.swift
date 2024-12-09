//
//  ViewFuns.swift
//  Sanqianfa
//
//  Created by 赵翔宇 on 2024/12/9.
//

import Foundation
import SwiftUI

extension View{
    func makeSQText(_ font : Font, color : Color) -> some View {
        self.font(font)
            .foregroundColor(color)
    }
}
