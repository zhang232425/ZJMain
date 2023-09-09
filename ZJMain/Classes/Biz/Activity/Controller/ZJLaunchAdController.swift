//
//  ZJLaunchViewController.swift
//  ZJMain
//
//  Created by Jercan on 2023/9/8.
//

import UIKit

class ZJLaunchAdController: BaseViewController {
    
//    private let interval: Int?
//
//    private let link: LaunchAdLink?
//
//    private let id: String?
    
    private lazy var btn = UIButton(type: .custom).then {
        $0.setTitle("我是广告页", for: .normal)
        $0.setTitleColor(UIColor.red, for: .normal)
        $0.addTarget(self, action: #selector(btnClick), for: .touchUpInside)
    }
    
//    init(image: UIImage, interval: Int, link: LaunchAdLink?, id: String?) {
//        self.interval = interval
//        self.link = link
//        self.id = id
//        super.init(nibName: nil, bundle: nil)
//    }
    
//    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
//        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
//        setupViews()
//    }
//
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    


}

private extension ZJLaunchAdController {
    
    func setupViews() {
        
        btn.add(to: view).snp.makeConstraints {
            $0.center.equalToSuperview()
        }
        
    }
    
    
}

private extension ZJLaunchAdController {
    
    @objc func btnClick() {
        
        let rootController = ZJTabBarController()
        
        UIApplication.shared.switchRootViewController(to: rootController, animated: true)
        
    }
    
}
