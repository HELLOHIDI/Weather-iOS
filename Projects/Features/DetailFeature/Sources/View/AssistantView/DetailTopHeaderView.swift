//
//  DetailTopHeaderView.swift
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

final class DetailTopHeaderView: UIView {
    
    // MARK: - Properties
    
    private let placeLabel = UILabel()
    let weatherLabel = UILabel()
    
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
            $0.isHidden = true
        }
        
        placeLabel.do {
            $0.textColor = .white
            $0.font = DSKitFontFamily.SFProDisplay.regular.font(size: 36)
        }
        
        weatherLabel.do {
            $0.textColor = .white
            $0.font = DSKitFontFamily.SFProDisplay.regular.font(size: 24)
        }
    }
    
    private func hieararchy() {
        self.addSubviews(placeLabel, weatherLabel)
    }
    
    private func layout() {
        placeLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(34.adjusted)
            $0.centerX.equalToSuperview()
        }
        
        weatherLabel.snp.makeConstraints {
            $0.top.equalTo(placeLabel.snp.bottom).offset(5)
            $0.centerX.equalToSuperview()
        }
    }
}

extension DetailTopHeaderView {
    func updateUI(_ data: WeatherModel?) {
        guard let data else { return }
        placeLabel.text = data.place
        weatherLabel.text = "\(data.temparature)° | \(data.weather)"
    }
}





