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
    
    private let scrollView = UIScrollView()
    private let contentView = UIView()
    let stackView = UIStackView()
    
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
        
        scrollView.do {
            $0.isPagingEnabled = true
            $0.showsHorizontalScrollIndicator = false
        }
        
        stackView.do {
            $0.axis = .horizontal
            $0.distribution = .fillEqually
            $0.spacing = 22
        }
    }
    
    private func hieararchy() {
        self.addSubviews(describeLabel, separator, scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(stackView)
    }
    
    private func layout() {
        describeLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(10)
            $0.leading.trailing.equalToSuperview().inset(15)
        }
        
        separator.snp.makeConstraints {
            $0.top.equalTo(describeLabel.snp.bottom).offset(11)
            $0.leading.equalToSuperview().offset(14)
            $0.trailing.equalToSuperview()
            $0.height.equalTo(1.adjusted)
        }
        
        scrollView.snp.makeConstraints {
            $0.top.equalTo(separator.snp.bottom)
            $0.leading.trailing.bottom.equalToSuperview()
        }
        
        contentView.snp.makeConstraints {
            $0.edges.equalTo(scrollView.contentLayoutGuide)
            $0.width.equalTo(scrollView.frameLayoutGuide).priority(.low)
            $0.height.equalTo(scrollView.frameLayoutGuide)
        }
        
        stackView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(14)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.bottom.equalToSuperview().inset(10)
        }
    }
}





