//
//  UserManager.swift
//  Sanqianfa
//
//  Created by 赵翔宇 on 2024/12/9.
//

import SwiftUI

class UserManager  : ObservableObject{
    static let shared : UserManager = .init()
    @Published var userLogged : Bool = false
}

