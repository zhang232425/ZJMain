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
    
    private let loader = ZJLaunchAdLoader()
    
    public init() {}
    
    public func initialize() {
        
        ZJMainRoutableTarget.register(path: ZJMainRoutePath.entry) { _ in // [weak loader = loader] _ in
            
//            if let loader = loader, let image = loader.lastImage {
//                return ZJLaunchAdController(image: image, interval: loader.interval, link: loader.link, id: loader.id)
//            }
            
            
//            return ZJNavigationController(rootViewController: ZJIdentityViewController())
            
//            return ZJLaunchAdController(image: image, interval: loader.interval, link: loader.link, id: loader.id)
            
            return ZJLaunchAdController()
            
        }
        
    }
    
}

/**
 if let loader = loader, let image = loader.lastImage {
                 return ASLaunchAdController(image: image, interval: loader.interval, link: loader.link, id: loader.id)
             }
             
             let controller: UIViewController
             
             if ASLoginManager.shared.isLogin {
                 
                 if let vc = ASGuideRoutableTarget.entry.viewController {
                     controller = vc
                 } else {
                     controller = ASNavigationController(wrapASTabBarController: .init())
                 }
                 
             } else {
         
                 controller = ASNavigationController(rootViewController: ASIdentityViewController())
             }
             
             return controller

 */
