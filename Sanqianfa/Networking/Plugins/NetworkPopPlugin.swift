//
//  WarningPlugin.swift
//  FantasyChat
//
//  Created by 赵翔宇 on 2022/8/1.
//

import Alamofire
import Foundation
import Moya

/// 通用网络插件
public class NetworkPopPlugin: PluginType {
    public init() {}

    /// 即将发送请求
    public func willSend(_: RequestType, target: TargetType) {}

    /// 收到返回结果时，一切返回结果都会走这里
    @MainActor
    public func didReceive(_ result: Result<Response, MoyaError>, target: TargetType) {
        switch result {
        case .success:

            switch result.HttpCode {
            case 206 :
                break
            case 200:
                switch result.messageCode {
                case 408:
                  break
                case 500:
                    break
                default:
                    break
                }
            case 400:
                // 用户未登录的时候，不报登录过期
                break
            case 401:
                // 没有传Header
                break
            case 407:
                break
            case 500:
                break
            case 502:
                break
            default:
                break
            }

        case .failure:
            break
        }
    }
}
