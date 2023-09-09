//
//  IdentityType.swift
//  Action
//
//  Created by Jercan on 2023/9/7.
//

import Foundation

enum IdentityType {
    case invest
    case borrower
}

extension IdentityType {

    var icon: String {
        switch self {
        case .invest:
            return "identity_invest"
        case .borrower:
            return "identity_borrow"
        }
    }
    
    var title: String {
        switch self {
        case .invest:
            return Locale.lender.localized
        case .borrower:
            return Locale.borrower.localized
        }
    }
    
    var desc: String {
        switch self {
        case .invest:
            return Locale.lenderDesc.localized
        case .borrower:
            return Locale.borrowerDesc.localized
        }
    }
    
    var go: String { Locale.go.localized }
    
}
