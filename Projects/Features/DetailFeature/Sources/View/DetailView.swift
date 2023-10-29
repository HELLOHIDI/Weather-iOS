//
//  DetailView.swift
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

final class DetailView: UIView {
    private let scrollView = UIScrollView()
    private let cellContentView = UIView()
    private let backgroundImageView = UIImageView()
    private let detailTopView = DetailTopView()
    private let detaiHourlyWeatherView = DetailHourlyWeatherView()
    
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
        backgroundImageView.do {
            $0.image = DSKitAsset.backgroundImg.image
        }
        
        scrollView.do {
            $0.alwaysBounceVertical = true
        }
    }
    
    private func hieararchy() {
        self.addSubviews(backgroundImageView, scrollView)
        scrollView.addSubview(cellContentView)
        cellContentView.addSubviews(
            detailTopView,
            detaiHourlyWeatherView
        )
    }
    
    private func layout() {
        backgroundImageView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        scrollView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.trailing.bottom.equalToSuperview()
        }
        
        cellContentView.snp.makeConstraints {
            $0.edges.equalTo(scrollView.contentLayoutGuide)
            $0.width.equalTo(scrollView.frameLayoutGuide)
            $0.height.equalTo(scrollView.frameLayoutGuide).priority(.low)
        }
        
        detailTopView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(78.adjusted)
            $0.leading.trailing.equalToSuperview().inset(111)
            $0.height.equalTo(212.adjusted)
        }
        
        detaiHourlyWeatherView.snp.makeConstraints {
            $0.top.equalTo(detailTopView.snp.bottom).offset(44)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.height.equalTo(212.adjusted)
        }
    }
}

extension DetailView {
    public func dataBind(_ data: WeatherModel?) {
        guard let data else { return }
        detailTopView.updateUI(data)
        updateHourlyWeatherUI(data.hourlyWeatherData)
    }
    
    private func updateHourlyWeatherUI(_ weatherList: [WeatherHourlyModel]) {
        (0..<weatherList.count).enumerated().map { index, _ in
            let weatherListView = DetailHourlyStackView()
            weatherListView.dataBind(weatherList[index])
            return weatherListView
        }.forEach(detaiHourlyWeatherView.stackView.addArrangedSubview)
    }
}
