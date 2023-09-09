//
//  ZJTabBarController.swift
//  ZJMain
//
//  Created by Jercan on 2023/9/5.
//

import ESTabBarController_swift
import RTRootNavigationController
import ZJRoutableTargets
import ZJRequest

class ZJTabBarController: ESTabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        config()
        setupViews()
    }

}

private extension ZJTabBarController {
    
    func config() {
        
        view.backgroundColor = .white
        
    }
    
    func setupViews() {
        
        tabBar.backgroundColor = .white
        tabBar.backgroundImage = UIImage(color: .white)
        tabBar.isTranslucent = false
        
        setDeviceToken()
        
        setViewControllers()
        
    }
    
    func setDeviceToken() {
        
        if ZJRequest.deviceToken == nil {
//            ZJRequest.deviceToken = ZJRemoteNotification.shared.deviceToken
        }
    
    }
    
}

private extension ZJTabBarController {
    
    func setViewControllers() {
        
        var controllers = [UIViewController]()
        
        let home = RTContainerNavigationController(rootViewController: ZJHomeRoutableTarget.home.viewController!)
        home.tabBarItem = ESTabBarItem(item: .home)
        controllers.append(home)
        
        let fund = RTContainerNavigationController(rootViewController: ZJFundRoutableTarget.fund.viewController!)
        fund.tabBarItem = ESTabBarItem(item: .fund)
        controllers.append(fund)
        
        let assets = RTContainerNavigationController(rootViewController: ZJAssetsRoutableTarget.assets.viewController!)
        assets.tabBarItem = ESTabBarItem(item: .assets)
        controllers.append(assets)
        
        let my = RTContainerNavigationController(rootViewController: ZJPersonalRoutableTarget.personal.viewController!)
        my.tabBarItem = ESTabBarItem(item: .my)
        controllers.append(my)
        
        viewControllers = controllers
        
    }
    
}
