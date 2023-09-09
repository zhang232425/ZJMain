//
//  LaunchAdInfo.swift
//  ZJMain
//
//  Created by Jercan on 2023/9/8.
//

import HandyJSON
import SwiftDate

struct LaunchAdResult: HandyJSON {
    
    var infos: [LaunchAdInfo]?
    
    mutating func mapping(mapper: HelpingMapper) {
        mapper <<< infos <-- "content"
    }
    
}

enum LaunchAdLink {
    
    case normal(url: String?)
    case insure(productId: String)
    
    init (string: String?) {
        if let urlStr = string,
           let url = URL(string: urlStr),
           let components = URLComponents(url: url, resolvingAgainstBaseURL: true),
           components.path.lowercased().contains("insurance"),
           let productId = components.queryItems?.filter({ $0.name == "productCode" }).first?.value {
            self = .insure(productId: productId)
        } else {
            self = .normal(url: string)
        }
            
    }
    
}

struct LaunchAdInfo: HandyJSON {
    
    var id = ""
    
    var adUrl: String?
    
    var imageUrl: String?
    
    var interval = 0
    
    var beginTime: NSNumber?
    
    var endTime: NSNumber?
    
    var startMinute: NSNumber?
    
    var endMinute: NSNumber?
    
    mutating func mapping(mapper: HelpingMapper) {
        mapper <<< adUrl <-- "url"
        mapper <<< imageUrl <-- "bannerUrl"
        mapper <<< interval <-- "lastTime"
        mapper <<< startMinute <-- "showBeginTime"
        mapper <<< endMinute <-- "showEndTime"
    }

}

extension LaunchAdInfo {
    
    var isValid: Bool {
        
        if let url = imageUrl, !url.isEmpty {
            
            let current = DateInRegion(region: Region(calendar: Calendars.gregorian,
                                                      zone: Zones.asiaJakarta,
                                                      locale: Locales.indonesianIndonesia))
            
            if let startInterval = beginTime, let endInterval = endTime,
                current > DateInRegion(seconds: startInterval.seconds, region: current.region),
                current < DateInRegion(seconds: endInterval.seconds, region: current.region) {
                
                if let sMin = startMinute, let eMin = endMinute {
                    
                    let cMin = NSNumber(value: current.hour * 60 + current.minute)
                    
                    if cMin.int64Value > sMin.int64Value, cMin.int64Value < eMin.int64Value {
                        return true
                    }
                    
                }
                
            }

        }
        
        return false
        
    }
    
    
    var link: LaunchAdLink { .init(string: adUrl) }
    
}

