//
//  ZJIdentityViewController.swift
//  Action
//
//  Created by Jercan on 2023/9/6.
//

import UIKit

class ZJIdentityViewController: BaseViewController {
    
    private lazy var label = UILabel().then {
        $0.text = "身份选择页"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
}

private extension ZJIdentityViewController {
    
    func setupViews() {
        
        label.add(to: view).snp.makeConstraints {
            $0.center.equalToSuperview()
        }
        
    }
    
}
