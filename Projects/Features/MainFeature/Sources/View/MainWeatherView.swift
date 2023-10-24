//
//  MainWeatherScrollView.swift
//  MainFeature
//
//  Created by 류희재 on 2023/10/23.
//  Copyright © 2023 baegteun. All rights reserved.
//

import UIKit

import Core

import SnapKit
import Then

final class MainWeatherView: UIView {
    
    // MARK: - UI Components
    
    let stackView = UIStackView()
    let weatherList1 = MainWeatherListView()
    let weatherList2 = MainWeatherListView()
    let weatherList3 = MainWeatherListView()
    let weatherList4 = MainWeatherListView()
    let weatherList5 = MainWeatherListView()
    let weatherList6 = MainWeatherListView()
    let weatherList7 = MainWeatherListView()
    
    
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
            $0.distribution = .fillEqually
            $0.spacing = 16
        }
    }
    
    private func hieararchy() {
        self.addSubview(stackView)
        stackView.addArrangedSubViews(
            weatherList1,
            weatherList2,
            weatherList3,
            weatherList4,
            weatherList5,
            weatherList6,
            weatherList7
        )
    }
    
    private func layout() {
        stackView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}
