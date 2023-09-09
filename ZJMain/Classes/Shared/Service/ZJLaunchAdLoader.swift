//
//  ZJLaunchAdLoader.swift
//  ZJMain
//
//  Created by Jercan on 2023/9/8.
//

import SDWebImage
import RxSwift
import RxSwiftExt

final class ZJLaunchAdLoader {
    
    private let info = UserDefaults.standard.lastLaunchAdInfo
    
    var lastImage: UIImage? {
        if let info = info, info.isValid, let url = info.imageUrl {
            let key = SDWebImageManager.shared.cacheKey(for: URL(string: url))
            return SDImageCache.shared.imageFromCache(forKey: key)
        }
        return nil
    }
    
    var interval: Int { info?.interval ?? 0 }
    
    var link: LaunchAdLink? { info?.link }
    
    var id: String? { info?.id }
    
    private let disposeBag = DisposeBag()
    
    init() {
        prefetch().subscribe().disposed(by: disposeBag)
    }
    
}

private extension ZJLaunchAdLoader {
    
    /** 备注：
     unwrap：
     接受一个可选元素序列，并返回一个非可选元素序列，过滤掉任何nil值。-返回:一个非可选元素的可观察序列
     */
    
    func prefetch() -> Observable<()> {
        Request.fetchLaunchAdInfo().map {
            UserDefaults.standard.lastLaunchAdInfo = $0
            return $0?.imageUrl
        }
        .asObservable()
        .unwrap()
        .map { URL(string: $0) }
        .flatMap { Request.downloadImage(url: $0) }
        .map { _ in }
    }

}
