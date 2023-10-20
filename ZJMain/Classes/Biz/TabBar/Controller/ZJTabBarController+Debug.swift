//
//  ZJTabBarController+Debug.swift
//  ZJMain
//
//  Created by Jercan on 2023/10/19.
//

#if DEBUG

import ZJCommonDefines
import ZJRoutableTargets
import ZJRouter
import ZJBase
import ZJLoginManager

extension ZJTabBarController {
    
    override var canBecomeFirstResponder: Bool { true }
    
    override func motionBegan(_ motion: UIEventSubtype, with event: UIEvent?) {
        
        let actionSheet = UIAlertController(title: "调试模式", message: "请选择要调试的功能", preferredStyle: .actionSheet)
        
        let action1 = UIAlertAction(title: "切换环境", style: .default) { _ in
            self.switchEnvironment()
        }
        
        let action2 = UIAlertAction(title: "路由调试", style: .default) { _ in
            self.routerDebug()
        }
        
        let action3 = UIAlertAction(title: "取消", style: .cancel) { _ in
            
        }
        
        actionSheet.addAction(action1)
        actionSheet.addAction(action2)
        actionSheet.addAction(action3)
        
        present(actionSheet, animated: true)
        
    }
    
    func switchEnvironment() {
        
        let env = ZJUrl.Environment.current
        
        let actionSheet = UIAlertController(title: "请选择你要切换的环境", message: "当前网络环境：\(env.desc)", preferredStyle: .actionSheet)
        
        ZJUrl.Environment.allCases.filter { $0 != env }.forEach { item in
            actionSheet.addAction(title: item.desc, style: .default) { _ in
                ZJUrl.Environment.current = item
                ZJLoginManager.shared.logout()
                exit(0)
            }
        }
        
        actionSheet.addAction(title: "取消", style: .cancel)
        
        present(actionSheet, animated: true)

    }
    
    func routerDebug() {
        
        let alertVC = UIAlertController(title: "调试路由", message: nil, preferredStyle: .alert)
        
        alertVC.addTextField { textField in
            textField.placeholder = "请输入要跳转的路由"
        }
        
        let action = UIAlertAction(title: "跳转", style: .default) { _ in
            
            if let tf = alertVC.textFields?.first {
                
                if !ZJLoginManager.shared.isLogin, let vc = ZJLoginRoutableTarget.login.viewController {
                    self.present(ZJNavigationController(rootViewController: vc), animated: false)
                    return
                }
                
//                ZJRouter.push(ZJRoutableTarget)
                
            }
            
        }
        
        let action1 = UIAlertAction(title: "取消", style: .cancel) { _ in
            
        }
        
        alertVC.addAction(action)
        alertVC.addAction(action1)
        
        present(alertVC, animated: true)
        
    }
    
}


#endif

