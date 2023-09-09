//
//  Locale.swift
//  Action
//
//  Created by Jercan on 2023/9/7.
//

import ZJLocalizable

enum Locale: String {
    
    case lender
    case lenderDesc
    case borrower
    case borrowerDesc
    case go
    
    case home
    case fund
    case assets
    case my    
}

extension Locale: ZJLocalizable {
    
    var key: String { rawValue }
    
    var table: String { "Locale" }
    
    var bundle: Bundle { .framework_ZJMain }

}
