//
//  DetailIndicatorCollectionViewCell.swift
//  DetailFeature
//
//  Created by 류희재 on 2023/10/26.
//  Copyright © 2023 hellohidi. All rights reserved.
//

import UIKit

import Core
import DSKit
import Domain

import SnapKit
import Then

final class DetailIndicatorCollectionViewCell: UICollectionViewCell {
    private let indicatorImageView = UIImageView()
    
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
        indicatorImageView.do {
            $0.image?.withRenderingMode(.alwaysTemplate)
        }
    }
    
    private func hieararchy() {
        contentView.addSubview(indicatorImageView)
    }
    
    private func layout() {
        indicatorImageView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}

extension DetailIndicatorCollectionViewCell {
    public func updateUI(_ index: Int, _ data: WeatherIndicatorModel) {
        if index == 0 { indicatorImageView.image = DSKitAsset.navigator.image }
        else { indicatorImageView.image = DSKitAsset.dot.image }
        
        indicatorImageView.image = indicatorImageView.image?.withRenderingMode(.alwaysTemplate)
        
        if data.isSelected { indicatorImageView.tintColor = .white }
        else { indicatorImageView.tintColor = .gray }
    }
}

