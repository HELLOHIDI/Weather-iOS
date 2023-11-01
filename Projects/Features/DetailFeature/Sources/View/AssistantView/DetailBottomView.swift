//
//  DetailBottomView.swift
//  DetailFeature
//
//  Created by 류희재 on 2023/10/26.
//  Copyright © 2023 hellohidi. All rights reserved.
//

import UIKit

import Core
import DSKit

import SnapKit
import Then

final class DetailBottomView: UIView {
    
    // MARK: - Properties
    
    let mapButton = UIButton()
    let listButton = UIButton()
    let pageControl = UIPageControl()
    
    // MARK: - UI Components
    
    // MARK: - Life Cycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        style()
        hieararchy()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Custom Method
    
    private func style() {
        self.do {
            $0.setBorder(
                borderWidth: 0.4,
                borderColor: .white.withAlphaComponent(0.4)
            )
            $0.backgroundColor = UIColor(red: 0.16, green: 0.19, blue: 0.25, alpha: 1)
        }
        
        mapButton.do {
            $0.setImage(DSKitAsset.map.image, for: .normal)
        }
        
        pageControl.do {
            $0.currentPageIndicatorTintColor = .white
            $0.pageIndicatorTintColor = .white.withAlphaComponent(0.5)
        }
        
        listButton.do {
            $0.setImage(DSKitAsset.list.image, for: .normal)
        }
    }
    
    private func hieararchy() {
        self.addSubviews(mapButton, pageControl, listButton)
    }
    
    private func layout() {
        mapButton.snp.makeConstraints {
            $0.top.equalToSuperview().offset(4)
            $0.leading.equalToSuperview().offset(10)
            $0.size.equalTo(44.adjusted)
        }
        
        listButton.snp.makeConstraints {
            $0.top.equalTo(mapButton)
            $0.trailing.equalToSuperview().inset(10)
            $0.size.equalTo(44.adjusted)
        }
        
        pageControl.snp.remakeConstraints {
            $0.top.equalToSuperview().offset(14)
            $0.width.equalTo(200)
            $0.centerX.equalToSuperview()
            $0.height.equalTo(24.adjusted)
        }
    }
}
