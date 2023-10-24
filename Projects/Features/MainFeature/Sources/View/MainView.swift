//
//  MainView.swift
//  MainFeature
//
//  Created by 류희재 on 2023/10/23.
//  Copyright © 2023 baegteun. All rights reserved.
//

import UIKit

import Core
import DSKit

import SnapKit
import Then

final class MainView: UIView {
    
    // MARK: - Properties
    
    private let menuButton = UIButton()
    
    private let scrollView = UIScrollView()
    private let contentView = UIView()
    private let titleLabel = UILabel()
    private let searchBar = UISearchBar()
    public let weatherView = MainWeatherView()
    
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
        menuButton.do {
            $0.setImage(DSKitAsset.menu.image, for: .normal)
        }
        
        titleLabel.do {
            $0.text = "날씨"
            $0.textColor = .white
            $0.font = DSKitFontFamily.SFProDisplay.bold.font(size: 36)
        }
        
        searchBar.do {
            $0.placeholder = "도시 또는 공항 검색"
            $0.barTintColor = .clear
        }
    }
    
    private func hieararchy() {
        self.addSubviews(
            menuButton,
            scrollView
        )
        scrollView.addSubview(contentView)
        contentView.addSubviews(
            titleLabel,
            searchBar,
            weatherView
        )
    }
    
    private func layout() {
        menuButton.snp.makeConstraints {
            $0.top.equalTo(safeAreaLayoutGuide).offset(8)
            $0.trailing.equalToSuperview().inset(10)
            $0.size.equalTo(40)
        }
        
        scrollView.snp.makeConstraints {
            $0.top.equalTo(safeAreaLayoutGuide).offset(53)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
        
        contentView.snp.makeConstraints {
            $0.edges.equalTo(scrollView.contentLayoutGuide)
            $0.width.equalTo(scrollView.frameLayoutGuide)
            $0.height.equalTo(scrollView.frameLayoutGuide).priority(.low)
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.equalToSuperview().offset(20)
        }
        
        searchBar.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(8)
            $0.leading.trailing.equalToSuperview().inset(15)
            $0.height.equalTo(40)
        }
        
        weatherView.snp.makeConstraints {
            $0.top.equalTo(searchBar.snp.bottom).offset(24)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
    }
}
