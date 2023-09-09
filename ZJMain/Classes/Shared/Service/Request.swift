//
//  Request.swift
//  ZJMain
//
//  Created by Jercan on 2023/9/8.
//

import RxSwift
import ZJRequest
import SDWebImage

struct Request {
    
    static func fetchLaunchAdInfo() -> Single<LaunchAdInfo?> {
        API.launchAd.rx.request()
            .mapObject(ZJRequestResult<LaunchAdResult>.self)
            .map { $0.data?.infos?.first}
    }
    
    static func downloadImage(url: URL?) -> Observable<UIImage> {
        
        .create { (observer) -> Disposable in
            let op = SDWebImageManager.shared.loadImage(with: url, progress: nil) { img, _, err, _, _, _ in
                if let image = img {
                    observer.onNext(image)
                    observer.onCompleted()
                } else if let error = err {
                    observer.onError(error)
                } else {
                    observer.onCompleted()
                }
            }
            return Disposables.create { op?.cancel() }
        }
    
    }
    
}


