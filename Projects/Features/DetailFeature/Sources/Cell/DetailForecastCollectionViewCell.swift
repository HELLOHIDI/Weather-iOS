//
//  DetailForecastWeatherCollectionViewCell.swift
//  DetailFeature
//
//  Created by 류희재 on 2023/11/02.
//  Copyright © 2023 hellohidi. All rights reserved.
//

import UIKit

import Core
import DSKit
import Domain

import SnapKit
import Then


final class DetailForecastCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Properties
    
    
    // MARK: - UI Components
    
    private let dateLabel = UILabel()
    private let weatherImageView = UIImageView()
    private let rainFallLabel = UILabel()
    private let minTemparatureLabel = UILabel()
    private let temparatureIndicatorBar = UIView()
    private let maxTemparatureLabel = UILabel()
    private let separator = UIView()
    
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
        dateLabel.do {
            $0.textColor = .white
            $0.textAlignment = .left
            $0.font = DSKitFontFamily.SFProDisplay.medium.font(size: 22)
        }
        
        rainFallLabel.do {
            $0.textColor = UIColor(red: 129, green: 207, blue: 250, alpha: 1)
            $0.textAlignment = .left
            $0.font = DSKitFontFamily.SFProDisplay.light.font(size: 15)
        }
        
        minTemparatureLabel.do {
            $0.textColor = .white
            $0.font = DSKitFontFamily.SFProDisplay.medium.font(size: 22)
        }
        
        temparatureIndicatorBar.do {
            $0.backgroundColor = .red
        }
        
        maxTemparatureLabel.do {
            $0.textColor = .white
            $0.font = DSKitFontFamily.SFProDisplay.medium.font(size: 22)
        }
        
        separator.do {
            $0.backgroundColor = .white
        }
    }
    
    private func hieararchy() {
        contentView.addSubviews(
            dateLabel,
            weatherImageView,
            rainFallLabel,
            minTemparatureLabel,
            temparatureIndicatorBar,
            maxTemparatureLabel,
            separator
        )
    }
    
    private func layout() {
        dateLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().offset(16)
        }
        weatherImageView.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().offset(87)
            $0.width.equalTo(28)
        }
        rainFallLabel.snp.makeConstraints {
            $0.top.equalTo(weatherImageView.snp.bottom).offset(0.85)
            $0.centerX.equalTo(weatherImageView)
        }
        minTemparatureLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalTo(weatherImageView.snp.trailing).offset(15)
        }
        temparatureIndicatorBar.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalTo(minTemparatureLabel.snp.trailing).offset(6)
            $0.width.equalTo(108)
            $0.height.equalTo(12.adjusted)
        }
        maxTemparatureLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().inset(17)
        }
        separator.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.trailing.equalToSuperview().inset(15)
            $0.height.equalTo(0.2)
        }
    }
}

extension DetailForecastCollectionViewCell {
    func dataBind(_ data: WeatherForecastModel) {
        dateLabel.text = data.day
        weatherImageView.image = data.weatherImg
        if let rainfall = data.rainfall {
            rainFallLabel.text = rainfall
        }
        minTemparatureLabel.text = "\(data.minTemparature)°"
        maxTemparatureLabel.text = "\(data.maxTemparature)°"
    }
}

