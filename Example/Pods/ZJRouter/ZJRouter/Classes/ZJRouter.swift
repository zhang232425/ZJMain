//
//  ZJRouter.swift
//  FBSnapshotTestCase
//
//  Created by Jercan on 2022/9/16.
//

import UIKit

public final class ZJRouter {
    
    private static var routesTable = [String: ZJInvoker]()
    
    private init() {}
    
    static func register(url: String, invoker: ZJInvoker) {
        return routesTable[url] = invoker
    }
    
    static func route(url: String) -> ZJInvoker? {
        return routesTable[url]
    }
    
}

public extension ZJRouter {
    
    static func register(path: ZJRoutePath, handler: @escaping (ZJRouteContext) -> UIViewController?) {
        register(url: path.value, invoker: ZJInvoker(handler: handler))
    }
    
    static func route(_ target: ZJRoutableTarget) -> UIViewController? {
        let path = target.path.value
        let parmaters = target.parameters
        return route(url: path)?.invoke(with: ZJRouteContext(url: path, parameters: parmaters ?? [:]))
    }
    
    @discardableResult
    static func push(_ target: ZJRoutableTarget, animated: Bool = true) -> Bool {
        
        guard let controller = route(target), let navigation = navigationController else { return false }
        
        navigation.pushViewController(controller, animated: animated)
        
        return true
        
    }
    
    @discardableResult
    static func present(_ target: ZJRoutableTarget, animated: Bool = true, completion: (() -> ())? = nil) -> Bool {
        
        guard let controller = route(target), let topController = topViewController else { return false }
        
        topController.present(controller, animated: animated, completion: completion)
        
        return true
        
    }

    
}

public extension ZJRouter {

    static var navigationController: UINavigationController? {
        
        guard let rootViewController = appRootViewController else {
            return nil
        }
        
        var navigationController: UINavigationController?
        
        if let vc = rootViewController as? UINavigationController {
            navigationController = vc
        }
        
        if let tabBarController = rootViewController as? UITabBarController,
            let vc = tabBarController.selectedViewController as? UINavigationController {
            navigationController = vc
        }
        
        guard var topViewController: UIViewController = navigationController else {
            return nil
        }
        
        while topViewController.presentedViewController != nil {
            topViewController = topViewController.presentedViewController!
        }
        
        return topViewController as? UINavigationController
        
    }
    
    static var topViewController: UIViewController? {
        
        if let rootViewController = appRootViewController {
            return topController(of: rootViewController)
        }
        
        return nil
        
    }
    
    
}

private extension ZJRouter {
        
    static var appRootViewController: UIViewController? {
        return (UIApplication.shared.delegate?.window as? UIWindow)?.rootViewController
    }
    
    static func topController(of viewController: UIViewController) -> UIViewController? {
        
        if let presentedViewController = viewController.presentedViewController {
            return topController(of: presentedViewController)
        }
        
        if let tabBarController = viewController as? UITabBarController,
            let selectedViewController = tabBarController.selectedViewController {
            return topController(of: selectedViewController)
        }
        
        if let navigationController = viewController as? UINavigationController,
            let visibleViewController = navigationController.visibleViewController {
            return topController(of: visibleViewController)
        }
        
        if let pageViewController = viewController as? UIPageViewController,
            pageViewController.viewControllers?.count == 1,
            let vc = pageViewController.viewControllers?.first {
            return topController(of: vc)
        }
        
        if let subviews = viewController.view?.subviews {
            
            for subview in subviews {
                if let childViewController = subview.next as? UIViewController {
                    return topController(of: childViewController)
                }
            }
            
        }
        
        return viewController
        
    }
    
}

