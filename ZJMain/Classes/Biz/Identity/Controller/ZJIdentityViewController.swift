//
//  ZJIdentityViewController.swift
//  Action
//
//  Created by Jercan on 2023/9/6.
//

import UIKit
import GKCycleScrollView
import ZJLocalizable

class ZJIdentityViewController: BaseViewController {
    
    private let dataSource: [IdentityType] = [.invest, .borrower]
    
    private lazy var iconImageView = UIImageView().then {
        $0.image = .named("logo")
    }
    
    private lazy var languageSwith = ZJSwitch().then {
        $0.leftTitle = "In"
        $0.rightTitle = "En"
        $0.addTarget(self, action: #selector(switchValueDidChange(sender:)), for: .valueChanged)
    }
        
    private lazy var scrollView = GKCycleScrollView().then {
        $0.backgroundColor = .white
        $0.isChangeAlpha = false
        $0.isAutoScroll = false
        $0.leftRightMargin = 18.auto
        $0.topBottomMargin = 26.auto
        $0.pageControl = pageControl
        $0.delegate = self
        $0.dataSource = self
    }
    
    private lazy var pageControl = UIPageControl().then {
        $0.numberOfPages = dataSource.count
        $0.currentPageIndicatorTintColor = .black
        $0.pageIndicatorTintColor = .lightGray
        $0.isUserInteractionEnabled = false
    }

    private lazy var ojkView = UIImageView().then {
        $0.image = .named("icon_ojk")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        bindViewModel()
    }
    
}

private extension ZJIdentityViewController {
    
    func setupViews() {
        
        iconImageView.add(to: view).snp.makeConstraints {
            $0.top.equalToSuperview().inset(8.auto)
            $0.left.equalToSuperview().inset(36.auto)
            $0.width.equalTo(121.auto)
            $0.height.equalTo(49.auto)
        }
        
        languageSwith.add(to: view).snp.makeConstraints {
            $0.right.equalToSuperview().inset(36.auto)
            $0.left.greaterThanOrEqualTo(iconImageView.snp.right).offset(15.auto)
            $0.centerY.equalTo(iconImageView)
        }
        
        scrollView.add(to: view).snp.makeConstraints {
            $0.left.right.equalToSuperview()
            $0.top.equalTo(iconImageView.snp.bottom).offset(2.auto)
        }
        
        pageControl.add(to: view).snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(scrollView.snp.bottom).offset(18.auto)
            $0.height.equalTo(10)
        }

        ojkView.add(to: view).snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(scrollView.snp.bottom).offset(37.auto)
            $0.width.equalTo(75.auto)
            $0.height.equalTo(40.auto)
            $0.bottom.equalToSuperview().inset(UIScreen.safeAreaBottom + 8.auto)
//            if #available(iOS 11.0, *) {
//                $0.bottom.equalTo(view.safeAreaLayoutGuide).inset(8.auto)
//            } else {
//                $0.bottom.equalTo(bottomLayoutGuide.snp.top).offset(-8)
//            }
        }
        
    }
    
    func bindViewModel() {
        
        NotificationCenter.default.rx.notification(ZJLocalizer.languageDidChangeNotification)
            .subscribe(onNext: { [weak self] _ in
                self?.scrollView.defaultSelectIndex = self?.scrollView.currentSelectIndex ?? 0
                self?.scrollView.reloadData()
            }).disposed(by: disposeBag)
        
        scrollView.reloadData()
        
    }
    
    func investClick() {
        print("点击了投资端")
    }
    
    func borrowClick() {
        print("点击了借款端")
    }
    
    @objc func switchValueDidChange(sender: ZJSwitch!) {
        
        switch sender.selectedIndex {
        case 0:
            ZJLocalizer.change(language: .id)
        case 1:
            ZJLocalizer.change(language: .en)
        default:
            break
        }
        
    }
    
}

extension ZJIdentityViewController: GKCycleScrollViewDelegate {
    
    func sizeForCell(in cycleScrollView: GKCycleScrollView!) -> CGSize {
        let scrollViewWidth = cycleScrollView.bounds.width
        let scrollViewHeight = cycleScrollView.bounds.height
        let size = fitSize(.init(width: scrollViewWidth - 72.auto, height: scrollViewHeight - 32.auto))
        pageControl.snp.updateConstraints {
            $0.top.equalTo(scrollView.snp.bottom).offset(-((scrollViewHeight - size.height) / 2  - 18.auto))
        }
        return size
    }
    
    func cycleScrollView(_ cycleScrollView: GKCycleScrollView!, didSelectCellAt index: Int) {
        
        if index == 0 {
            investClick()
        } else if index == 1 {
            borrowClick()
        }

        UserDefaults.standard.lastSelectIdentity = index
        
    }
    
}

extension ZJIdentityViewController: GKCycleScrollViewDataSource {
    
    func numberOfCells(in cycleScrollView: GKCycleScrollView!) -> Int {
        return dataSource.count
    }
    
    func cycleScrollView(_ cycleScrollView: GKCycleScrollView!, cellForViewAt index: Int) -> GKCycleScrollViewCell! {
        
        var cell = cycleScrollView.dequeueReusableCell() as? ZJIdentityItemCell
        if cell == nil {
            cell = ZJIdentityItemCell()
        }
        cell?.type = dataSource[index]
        return cell
        
    }

}

private extension ZJIdentityViewController {
    
    func fitSize(_ size: CGSize) -> CGSize {
        
        var desW: CGFloat = 0
        var desH: CGFloat = 0

        let cellW: CGFloat = 288
        let cellH: CGFloat = 371
        
        let wSpace = fabsf(Float(size.width - cellW))
        let hSpace = fabsf(Float(size.height - cellH))
        
        if wSpace >= hSpace {
            if size.width > cellW {
                desW = cellW * (size.height / cellH)
                desH = cellH * (size.height / cellH)
            } else {
                desW = cellW / (cellW / size.width)
                desH = cellH / (cellW / size.width)
            }
        } else {
            if size.height > cellH {
                desW = cellW * (size.width / cellW)
                desH = cellH * (size.width / cellW)
            } else {
                desW = cellW / (cellH / size.height)
                desH = cellH / (cellH / size.height)
            }
        }
        
        return .init(width: desW, height: desH)
        
    }
    
}
