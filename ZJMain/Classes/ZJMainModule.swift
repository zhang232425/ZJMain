//
//  ZJMainModule.swift
//  Pods-ZJMain_Example
//
//  Created by Jercan on 2023/9/5.
//

import ZJRouter
import ZJRoutableTargets
import ZJBase

public struct ZJMainModule: ZJModule {
    
    public init() {}
    
    public func initialize() {
        
        ZJMainRoutableTarget.register(path: ZJMainRoutePath.entry) { _ in
            return ZJNavigationController(rootViewController: ZJIdentityViewController())
        }
        
    }
    
}

