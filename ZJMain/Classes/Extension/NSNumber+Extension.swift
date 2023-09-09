//
//  NSNumber+Extension.swift
//  ZJMain
//
//  Created by Jercan on 2023/9/8.
//

import SwiftDate

extension NSNumber {
    
    var seconds: TimeInterval {
        return TimeInterval(doubleValue / 1000)
    }
    
}

extension TimeInterval {
    
    func dateString(format: String = "dd/MM/yyyy HH:mm") -> String? {
        
        let date = Date(seconds: self)
        return date.formatter(format: format) {
            $0.locale = Locales.indonesianIndonesia.toLocale()
            $0.timeZone = Zones.current.toTimezone()
        }.string(from: date)
        
    }
    
}
