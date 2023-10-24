//
//  DetailTopView.swift
//  DetailFeature
//
//  Created by 류희재 on 2023/10/25.
//  Copyright © 2023 hellohidi. All rights reserved.
//

import UIKit
import DSKit
import Core

import SnapKit
import Then

final class DetailTopView: UIView {
    
    // MARK: - Properties
    
    private let stackView = UIStackView()
    
    private let placeLabel = UILabel()
    private let temparatureLabel = UILabel()
    private let weatherLabel = UILabel()
    private let maxmimTemparatureLabel = UILabel()
    
    
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
        stackView.do {
            $0.axis = .vertical
            $0.distribution = .equalSpacing
            $0.spacing = 4
        }
        placeLabel.do {
            $0.text = "의정부시"
            $0.textColor = .white
            $0.textAlignment = .center
            $0.font = DSKitFontFamily.SFProDisplay.regular.font(size: 36)
        }
        
        temparatureLabel.do {
            $0.text = "21"
            $0.textColor = .white
            $0.textAlignment = .center
            $0.font = DSKitFontFamily.SFProDisplay.thin.font(size: 102)
        }
        
        weatherLabel.do {
            $0.text = "흐림"
            $0.textColor = .white
            $0.textAlignment = .center
            $0.font = DSKitFontFamily.SFProDisplay.regular.font(size: 24)
        }
        
        maxmimTemparatureLabel.do {
            $0.text = "asdfasdf"
            $0.textColor = .white
            $0.textAlignment = .center
            $0.font = DSKitFontFamily.SFProDisplay.medium.font(size: 20)
        }
    }
    
    private func hieararchy() {
        self.addSubview(stackView)
        stackView.addArrangedSubViews(
            placeLabel,
            temparatureLabel,
            weatherLabel,
            maxmimTemparatureLabel
        )
    }
    
    private func layout() {
        stackView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}





