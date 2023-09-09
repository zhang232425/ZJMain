//
//  Bundle+Extension.swift
//  ZJMain
//
//  Created by Jercan on 2023/9/6.
//

import Foundation

extension Bundle {
    
    static var framework_ZJMain: Bundle {
        let frameworkName = "ZJMain"
        let resourcePath: NSString = .init(string: Bundle(for: ZJMainClass.self).resourcePath ?? "")
        let path = resourcePath.appendingPathComponent("/\(frameworkName).bundle")
        return Bundle(path: path)!
    }
    
    private class ZJMainClass {}
    
}
