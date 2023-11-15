//
//  MainWeatherListView.swift
//  MainFeature
//
//  Created by 류희재 on 2023/10/24.
//  Copyright © 2023 hellohidi. All rights reserved.
//

import UIKit

import Core
import DSKit
import Domain

import SnapKit
import Then

final class MainWeatherCollectionViewCell: UICollectionViewCell {
    
    // MARK: - UI Components
    
    private let weatherImageView = UIImageView()
    private let placeLabel = UILabel()
    private let timeLabel = UILabel()
    private let weatherLabel = UILabel()
    private let temparatureLabel = UILabel()
    private let maximumTemparatureLabel = UILabel()
    private let minimumTemparatureLabel = UILabel()
    
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
        weatherImageView.do {
            $0.image = DSKitAsset.listImg.image
        }
        
        placeLabel.do {
            $0.text = "나의 위치"
            $0.font = DSKitFontFamily.SFProDisplay.bold.font(size: 24)
            $0.textColor = .white
        }
        
        timeLabel.do {
            $0.font = DSKitFontFamily.SFProDisplay.medium.font(size: 17)
            $0.textColor = .white
        }
        
        weatherLabel.do {
            $0.font = DSKitFontFamily.SFProDisplay.medium.font(size: 16)
            $0.textColor = .white
        }
        
        temparatureLabel.do {
            $0.font = DSKitFontFamily.SFProDisplay.thin.font(size: 52)
            $0.textColor = .white
        }
        
        maximumTemparatureLabel.do {
            $0.font = DSKitFontFamily.SFProDisplay.medium.font(size: 15)
            $0.setKerning(withKerning: 0.75)
            $0.textColor = .white
        }
        
        minimumTemparatureLabel.do {
            $0.font = DSKitFontFamily.SFProDisplay.medium.font(size: 15)
            $0.setKerning(withKerning: 0.75)
            $0.textColor = .white
        }
    }
    
    private func hieararchy() {
        self.addSubview(weatherImageView)
        weatherImageView.addSubviews(
            placeLabel,
            timeLabel,
            weatherLabel,
            temparatureLabel,
            maximumTemparatureLabel,
            minimumTemparatureLabel
        )
    }
    
    private func layout() {
        weatherImageView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        placeLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(15)
            $0.leading.equalToSuperview().offset(20)
        }
        
        timeLabel.snp.makeConstraints {
            $0.top.equalTo(placeLabel.snp.bottom).offset(2)
            $0.leading.equalTo(placeLabel)
        }
        
        weatherLabel.snp.makeConstraints {
            $0.top.equalTo(timeLabel.snp.bottom).offset(23)
            $0.leading.equalTo(placeLabel)
        }
        
        temparatureLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(5)
            $0.trailing.equalToSuperview().inset(22)
        }
        
        maximumTemparatureLabel.snp.makeConstraints {
            $0.top.equalTo(weatherLabel)
            $0.trailing.equalToSuperview().inset(83)
        }
        
        minimumTemparatureLabel.snp.makeConstraints {
            $0.top.equalTo(maximumTemparatureLabel)
            $0.trailing.equalToSuperview().inset(20)
        }
    }
    
    func dataBind(_ data: CurrentWeatherModel) {
        self.tag = data.tag
        timeLabel.text = data.time
        placeLabel.text = data.place
        weatherLabel.text = data.weather
        temparatureLabel.text = "\(Int(data.temparature - 273))°"
        maximumTemparatureLabel.text = "최고:\(Int(data.maxTemparature - 273))°"
        minimumTemparatureLabel.text = "최저:\(Int(data.minTemparature - 273))°"
    }
}





