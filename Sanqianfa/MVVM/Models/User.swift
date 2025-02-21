//
//  User.swift
//  Sanqianfa
//
//  Created by 赵翔宇 on 2025/2/21.
//

import SwiftUI
import KakaJSON


struct User : Convertible {
    var id : String = ""
    var username : String = ""
    var update_time : String = ""
    var is_active : Bool = true
    var phone_number : String = ""
    var shortid : String = ""
    var created_at : String = ""
    var updated_at : String = ""
}

