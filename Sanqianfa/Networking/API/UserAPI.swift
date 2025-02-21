//
//  UserAPI.swift
//  Sanqianfa
//
//  Created by 赵翔宇 on 2025/2/21.
//

import Foundation



enum UserAPI: SQAPITarget {
    ///  短信验证码注册
    case profile
    
    var group: String {
        return "/api/v1/user"
    }

    var method: HTTPRequestMethod {
        switch self {
        case .profile : return .get
        default: return .post
        }
    }

    var parameters: [String: Any]? {
        switch self {
        default : return nil
        
        }
    }
}
