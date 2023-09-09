//
//  ZJIdentityItemCell.swift
//  Action
//
//  Created by Jercan on 2023/9/7.
//

import GKCycleScrollView
import BadgeSwift
import ZJExtension

class ZJIdentityItemCell: GKCycleScrollViewCell {
    
    var type: IdentityType? {
        didSet {
            imageView.image = nil
            if let imageName = type?.icon, !imageName.isEmpty {
                imageView.image = .named(imageName)
            }
            titleLabel.text = type?.title
            descLabel.text = type?.desc
            goLabel.text = type?.go
        }
    }
    
    private lazy var titleLabel = UILabel().then {
        $0.textColor = .white
        $0.font = .bold26
        $0.adjustsFontSizeToFitWidth = true
    }
    
    private lazy var descLabel = UILabel().then {
        $0.textColor = UIColor(hexString: "#F6F6F6")
        $0.font = .medium12
        $0.adjustsFontSizeToFitWidth = true
    }
    
    /** 备注：
     * setContentHuggingPriority：抗拉伸属性
     * setContentCompressionResistancePriority：抗压缩属性
     */
    private lazy var goLabel = BadgeSwift().then {
        $0.setContentHuggingPriority(.defaultHigh + 1, for: .horizontal)
        $0.setContentCompressionResistancePriority(.defaultHigh + 1, for: .horizontal)
        $0.textColor = .white
        $0.font = .bold20
        $0.badgeColor = UIColor(hexString: "#FF7D0F")
        $0.insets = .init(width: min(34.auto, 34), height: 6)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

private extension ZJIdentityItemCell {
    
    func setupViews() {
        
        descLabel.add(to: imageView).snp.makeConstraints {
            $0.left.equalToSuperview().inset(26)
            $0.bottom.equalToSuperview().inset(38)
        }
        
        titleLabel.add(to: imageView).snp.makeConstraints {
            $0.left.right.equalTo(descLabel)
            $0.bottom.equalTo(descLabel.snp.top).offset(-3)
        }
        
        goLabel.add(to: imageView).snp.makeConstraints {
            $0.left.equalTo(titleLabel.snp.right).offset(20)
            $0.right.equalToSuperview().inset(26)
            $0.bottom.equalToSuperview().inset(40)
        }
        
    }
    
}

