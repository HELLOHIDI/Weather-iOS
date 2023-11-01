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
    private let contentView = UIView()
    private let backgroundImageView = UIImageView.init(image: DSKitAsset.backgroundImg.image)
    let detailTopView = DetailTopView()
    let detaiHourlyWeatherView = DetailHourlyWeatherView()
    let detailForecastWeatherView = DetailForecastWeatherView()
    
    // MARK: - UI Components
    
    // MARK: - Life Cycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        hieararchy()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Custom Method
    
    private func hieararchy() {
        self.addSubviews(backgroundImageView, scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubviews(
            detailTopView,
            detaiHourlyWeatherView,
            detailForecastWeatherView
        )
    }
    
    private func layout() {
        backgroundImageView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        scrollView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.bottom.equalToSuperview().inset(100)
        }
        
        contentView.snp.makeConstraints {
            let contentHeight = 78.adjusted + 212.adjusted + 44 + 212.adjusted + 20 + 550.adjusted
            $0.edges.equalTo(scrollView.contentLayoutGuide)
            $0.width.equalTo(scrollView.frameLayoutGuide)
            $0.height.equalTo(contentHeight).priority(.low)
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
        
        detailForecastWeatherView.snp.makeConstraints {
            $0.top.equalTo(detaiHourlyWeatherView.snp.bottom).offset(20)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.height.equalTo(550.adjusted)
        }
    }
}
