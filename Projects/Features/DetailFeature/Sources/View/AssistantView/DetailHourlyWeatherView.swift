//
//  DetaiHourlyWeatherView.swift
//  DetailFeature
//
//  Created by 류희재 on 2023/10/25.
//  Copyright © 2023 hellohidi. All rights reserved.
//

import UIKit

import Core
import DSKit

import SnapKit
import Then

final class DetailHourlyWeatherView: UIView {
    
    // MARK: - Properties
    
    private let describeLabel = UILabel()
    private let separator = UIView()
    let hourlyCollectionView = UICollectionView.init(frame: .zero, collectionViewLayout: .init())
    
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
        hourlyCollectionView.register(
            DetailHourlyCollectionViewCell.self,
            forCellWithReuseIdentifier: DetailHourlyCollectionViewCell.cellIdentifier
        )
    }
    
    private func style() {
        self.do {
            $0.backgroundColor = .clear
            $0.makeCornerRound(radius: 15)
            $0.setBorder(borderWidth: 0.5, borderColor: .white.withAlphaComponent(0.25))
        }
        
        describeLabel.do {
            $0.text = "08:00~09:00에 강우 상태가, 18:00에 한때 흐린 상태가 예상됩니다."
            $0.font = DSKitFontFamily.SFProDisplay.regular.font(size: 18)
            $0.textColor = .white
            $0.numberOfLines = 2
        }
        
        separator.do {
            $0.backgroundColor = .white
        }
        
        hourlyCollectionView.do {
            let layout = UICollectionViewFlowLayout()
            layout.scrollDirection = .horizontal
            layout.itemSize = CGSize(
                width: 50.adjusted,
                height: 122.adjusted
            )
            layout.minimumLineSpacing = 22
            layout.minimumInteritemSpacing = 0
            
            $0.collectionViewLayout = layout
            $0.backgroundColor = .clear
            $0.showsHorizontalScrollIndicator = false
        }
    }
    
    private func hieararchy() {
        self.addSubviews(describeLabel, separator, hourlyCollectionView)
    }
    
    private func layout() {
        describeLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(10.adjusted)
            $0.leading.trailing.equalToSuperview().inset(15)
        }
        
        separator.snp.makeConstraints {
            $0.top.equalTo(describeLabel.snp.bottom).offset(11.adjusted)
            $0.leading.equalToSuperview().offset(14)
            $0.trailing.equalToSuperview()
            $0.height.equalTo(1.adjusted)
        }
        
        hourlyCollectionView.snp.makeConstraints {
            $0.top.equalTo(separator.snp.bottom).offset(14.adjusted)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.bottom.equalToSuperview().inset(10.adjusted)
        }
    }
}





