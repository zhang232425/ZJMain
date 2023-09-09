//
//  API.swift
//  Action
//
//  Created by Jercan on 2023/9/6.
//

import Moya
import ZJRequest
import ZJCommonDefines

enum API {
    
    case launchAd
    
}

extension API: ZJRequestTargetType {
    
    var headers: [String : String]? { nil }
    
    var baseURL: URL { URL(string: ZJUrl.server)! }
    
    var path: String {
        
        switch self {
        case .launchAd:
            return "/api/app/activity/activity/list/version/app"
        }
        
    }
    
    var method: Moya.Method {
        
        switch self {
        case .launchAd:
            return .get
        }
        
    }
    
    var task: Task {
        
        switch self {
        case .launchAd:
            var params: [String: Any] = [:]
            params["modelType"] = "screen"
            return .requestParameters(parameters: params, encoding: URLEncoding.default) // JSONEncoding
        }
        
    }
    
    var sampleData: Data { ".".data(using: .utf8)! }
    
}
