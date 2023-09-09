//
//  UserDefaults+Extension.swift
//  ZJMain
//
//  Created by Jercan on 2023/9/7.
//

import Foundation

extension UserDefaults {
    
    var lastSelectIdentity: Int {
        set {
            set(newValue, forKey: #function)
            synchronize()
        }
        get {
            integer(forKey: #function)
        }
    }
    
    var lastLaunchAdInfo: LaunchAdInfo? {
        set {
            set(newValue?.toJSONString(), forKey: #function)
            synchronize()
        }
        get { LaunchAdInfo.deserialize(from: string(forKey: #function)) }
    }
    
}


