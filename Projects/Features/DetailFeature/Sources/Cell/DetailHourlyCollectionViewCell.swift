//
//  DetailHourlyStackView.swift
//  DetailFeature
//
//  Created by 류희재 on 2023/10/25.
//  Copyright © 2023 hellohidi. All rights reserved.
//

import UIKit

import Core
import DSKit
import Domain

import SnapKit
import Then


final class DetailHourlyCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Properties
    
    
    // MARK: - UI Components
    
    private let stackView = UIStackView()
    private let timeLabel = UILabel()
    private let weatherImageView = UIImageView()
    private let temparatureLabel = UILabel()
    
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
        stackView.do {
            $0.axis = .vertical
            $0.distribution = .equalSpacing
            $0.spacing = 14
        }
        
        timeLabel.do {
            $0.font = DSKitFontFamily.SFProDisplay.medium.font(size: 17)
            $0.textAlignment = .center
            $0.textColor = .white
        }
        
        temparatureLabel.do {
            $0.font = DSKitFontFamily.SFProDisplay.medium.font(size: 22)
            $0.textAlignment = .center
            $0.textColor =  .white
        }
    }
    
    private func hieararchy() {
        self.addSubview(stackView)
        stackView.addArrangedSubViews(
            timeLabel,
            weatherImageView,
            temparatureLabel
        )
    }
    
    private func layout() {
        stackView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    func dataBind(_ data: WeatherHourlyModel) {
        timeLabel.text = data.time
        weatherImageView.image = data.weatherImage
        temparatureLabel.text = data.temparature
    }
}





