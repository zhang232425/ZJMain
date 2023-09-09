//
//  ZJTabBarItemContentView.swift
//  ZJMain
//
//  Created by Jercan on 2023/9/9.
//

import ESTabBarController_swift
import SnapKit
import ZJDevice

/** 备注：swift 枚举学习
 https://juejin.cn/post/6937578808300027912
 遵守CaseIterable 协议的swift枚举是可以遍历的，通过allCases获取所有的枚举成员.
 */

enum ZJTabItem: CaseIterable {
    case home
    case fund
    case assets
    case my
}

extension ZJTabItem {
    
    var title: String {
        switch self {
        case .home:
            return Locale.home.localized
        case .fund:
            return Locale.fund.localized
        case .assets:
            return Locale.assets.localized
        case .my:
            return Locale.my.localized
        }
    }
    
    var imageName: String {
        switch self {
        case .home:
            return "tab_home"
        case .fund:
            return "tab_fund"
        case .assets:
            return "tab_assets"
        case .my:
            return "tab_my"
        }
    }
    
    var selectedImageName: String {
        switch self {
        case .home:
            return "tab_home_s"
        case .fund:
            return "tab_fund_s"
        case .assets:
            return "tab_assets_s"
        case .my:
            return "tab_my_s"
        }
    }
    
}

extension ESTabBarItem {
    
    convenience init(item: ZJTabItem) {
        self.init(ZJTabBarItemContentView(),
                  title: item.title,
                  image: .named(item.imageName),
                  selectedImage: .named(item.selectedImageName))
    }
    
}

class ZJTabBarItemContentView: ESTabBarItemContentView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        textColor = UIColor(hexString: "#333333")
        highlightTextColor = UIColor(hexString: "#FA780A")
        titleLabel.font = .bold10
        itemContentMode = .alwaysOriginal
        renderingMode = .alwaysOriginal
        if !ZJDevice().isXseries {
            insets = .init(top: 0, left: 0, bottom: 2, right: 0)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func selectAnimation(animated: Bool, completion: (() -> ())?) {
        bounceAnimation()
        completion?()
    }
    
    override func reselectAnimation(animated: Bool, completion: (() -> ())?) {
        bounceAnimation()
        completion?()
    }
    
    private func bounceAnimation() {
        
        let impliesAnimation = CAKeyframeAnimation(keyPath: "transform.scale")
        impliesAnimation.values = [1.0, 1.3, 1.0, 0.95, 1.0]
        impliesAnimation.duration = 0.5
        impliesAnimation.calculationMode = kCAAnimationCubic
        imageView.layer.add(impliesAnimation, forKey: nil)
        
    }
    
}
