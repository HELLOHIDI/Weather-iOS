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
    let indicatorCollectionView = UICollectionView(frame: .zero, collectionViewLayout: .init())
    let listButton = UIButton()
    
    // MARK: - UI Components
    
    // MARK: - Life Cycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        register()
        
        style()
        hieararchy()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Custom Method
    
    private func register() {
        indicatorCollectionView.register(DetailIndicatorCollectionViewCell.self, forCellWithReuseIdentifier: DetailIndicatorCollectionViewCell.cellIdentifier)
    }
    
    private func style() {
        self.do {
            $0.setBorder(
                borderWidth: 0.4,
                borderColor: .white.withAlphaComponent(0.4)
            )
            $0.backgroundColor = .clear
        }
        
        mapButton.do {
            $0.setImage(DSKitAsset.map.image, for: .normal)
        }
        
        indicatorCollectionView.do {
            let layout = UICollectionViewFlowLayout()
            layout.scrollDirection = .horizontal
            layout.itemSize = CGSize(
                width: 24.adjusted,
                height: 24.adjusted
            )
            layout.minimumLineSpacing = 4
            layout.minimumInteritemSpacing = 0
            
            $0.collectionViewLayout = layout
            $0.backgroundColor = .clear
            $0.isScrollEnabled = false
        }
        
        listButton.do {
            $0.setImage(DSKitAsset.list.image, for: .normal)
        }
    }
    
    private func hieararchy() {
        self.addSubviews(mapButton, listButton, indicatorCollectionView)
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
    }
}

extension DetailBottomView {
    public func updateLayout(_ indicatorCnt: Int) {
        indicatorCollectionView.snp.remakeConstraints {
            let width = indicatorCnt * Int(24.adjusted) + (indicatorCnt - 1) * 4
            $0.top.equalToSuperview().offset(14)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(width)
            $0.height.equalTo(24.adjusted)
        }
    }
}
