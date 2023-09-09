//
//  ZJSwitch.swift
//  Action
//
//  Created by Jercan on 2023/9/6.
//

import UIKit
import Then
import ZJExtension

class ZJSwitch: UIControl {
    
    var leftTitle: String? {
        didSet {
            leftLabel.text = leftTitle
            leftSelectLabel.text = leftTitle
            setNeedsLayout()
        }
    }
    
    var rightTitle: String? {
        didSet {
            rightLabel.text = rightTitle
            rightSelectLabel.text = rightTitle
            setNeedsLayout()
        }
    }
    
    override class var layerClass: AnyClass {
        return ZJLanguageSwitchRoundedLayer.self
    }
    
    private lazy var leftLabel = UILabel().then {
        $0.font = .regular13
        $0.textColor = .black
    }
    
    private lazy var leftSelectLabel = UILabel().then {
        $0.font = .regular13
        $0.textColor = .black
    }
    
    private lazy var rightLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 13, weight: .regular)
        $0.textColor = .black
    }
    
    private lazy var rightSelectLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 13, weight: .regular)
        $0.textColor = .black
    }
    
    private lazy var selectedBackgroundView = UIView().then {
        $0.backgroundColor = .white
        object_setClass($0.layer, ZJLanguageSwitchRoundedLayer.self)
        $0.layer.shadowColor = UIColor(hexString: "#BFBFBF").cgColor
        $0.layer.shadowOffset = .zero
        $0.layer.shadowOpacity = 1
        $0.addObserver(self, forKeyPath: "frame", options: .new, context: nil)
    }
    
    private lazy var selectedLabelContentView = UIView().then {
        $0.layer.mask = titleMaskView.layer
    }
    
    private lazy var titleMaskView = UIView().then {
        $0.backgroundColor = .black
        object_setClass($0.layer, ZJLanguageSwitchRoundedLayer.self)
    }
    
    private(set) var selectedIndex: Int = 0

    override init(frame: CGRect) {
        super.init(frame: frame)
        config()
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let frame: CGRect
        if selectedIndex == 0 {
            frame = CGRect(x: 0, y: 0, width: leftLabel.bounds.width + 44, height: bounds.height)
        } else {
            frame = CGRect(x: bounds.width - rightLabel.bounds.width - 44, y: 0, width: rightLabel.bounds.width + 44, height: bounds.height)
        }
        
        selectedBackgroundView.frame = frame
        titleMaskView.frame = selectedBackgroundView.frame
    }
    
    deinit {
        selectedBackgroundView.removeObserver(self, forKeyPath: "frame")
    }
    
}

private extension ZJSwitch {
    
    func config() {
        backgroundColor = UIColor(hexString: "#E4E4E4")
    }
    
    func setupViews() {
        
        leftLabel.add(to: self).snp.makeConstraints {
            $0.left.equalToSuperview().inset(22)
            $0.top.bottom.equalToSuperview().inset(7)
        }
        
        rightLabel.add(to: self).snp.makeConstraints {
            $0.right.equalToSuperview().inset(22)
            $0.top.bottom.equalTo(leftLabel)
            $0.left.equalTo(leftLabel.snp.right).offset(30)
        }
        
        addSubview(selectedBackgroundView)
        
        selectedLabelContentView.add(to: self).snp.makeConstraints {
            $0.edges.equalToSuperview()
        }

        leftSelectLabel.add(to: selectedLabelContentView).snp.makeConstraints {
            $0.left.equalToSuperview().inset(22)
            $0.centerY.equalToSuperview()
        }

        rightSelectLabel.add(to: selectedLabelContentView).snp.makeConstraints {
            $0.right.equalToSuperview().inset(22)
            $0.centerY.equalToSuperview()
            $0.left.equalTo(leftSelectLabel.snp.right).offset(30)
        }

        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tap(_:)))
        addGestureRecognizer(tapGesture)
        
    }
    
    func setSelectedIndex(_ index: Int, animated: Bool) {
        
        guard selectedIndex != index else { return }
        selectedIndex = index
        if animated {
            sendActions(for: .valueChanged)
            UIView.animate(withDuration: 0.25) { self.layoutSubviews() }
        } else {
            layoutSubviews()
            sendActions(for: .valueChanged)
        }
        
    }
    
    @objc func tap(_ sender: UITapGestureRecognizer) {
        
        let location = sender.location(in: self)
        if selectedBackgroundView.frame.maxX < location.x {
            setSelectedIndex(1, animated: true)
        } else if selectedBackgroundView.frame.minX > location.x {
            setSelectedIndex(0, animated: true)
        }
        
    }
    
}

extension ZJSwitch {
    
    override func observeValue(forKeyPath keyPath: String?,
                                     of object: Any?,
                                     change: [NSKeyValueChangeKey : Any]?,
                                     context: UnsafeMutableRawPointer?) {
        if keyPath == "frame" {
            titleMaskView.frame = selectedBackgroundView.frame
        }
    }
    
}

private class ZJLanguageSwitchRoundedLayer: CALayer {
    
    override var bounds: CGRect {
        didSet { cornerRadius = bounds.height * 0.5 }
    }
    
}

