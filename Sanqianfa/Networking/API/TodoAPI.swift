//
//  TodoAPI.swift
//  Sanqianfa
//
//  Created by 赵翔宇 on 2025/2/20.
//

import SwiftUI

enum TodoAPI: SQAPITarget {
    ///  短信验证码注册
    case all
    var group: String {
        return "/api/v1/todo"
    }

    var method: HTTPRequestMethod {
        switch self {
        case .all : return .get
        default: return .post
        }
    }

    var parameters: [String: Any]? {
        switch self {
        default : return nil
        
        }
    }
}
