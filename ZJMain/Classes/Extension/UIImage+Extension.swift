//
//  UIImage+Extension.swift
//  ZJMain
//
//  Created by Jercan on 2023/9/6.
//

import ZJExtension

extension UIImage {
    
    static func named(_ name: String) -> UIImage? {
        let img = UIImage(name: name, bundle: .framework_ZJMain)
        return img
    }
    
}
