//
//  DetailForeCaseHeaderView.swift
//  DetailFeature
//
//  Created by 류희재 on 2023/11/02.
//  Copyright © 2023 hellohidi. All rights reserved.
//

import UIKit

import DSKit

class DetailForecastHeaderView: UICollectionReusableView {
    
    //MARK: - UI Components
    
    private let calanderImageView = UIImageView.init(image: UIImage(systemName: "calendar"))
    private let titleLabel = UILabel()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        style()
        hierarchy()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func style() {
        titleLabel.do {
            $0.text = "10일간의 일기예보"
            $0.font = DSKitFontFamily.SFProDisplay.medium.font(size: 15)
            $0.textColor = .white
        }
    }
    private func hierarchy() {
        self.addSubviews(calanderImageView, titleLabel)
    }
    private func layout() {
        calanderImageView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(8)
            $0.leading.equalToSuperview().offset(15)
            $0.size.equalTo(15)
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(calanderImageView)
            $0.leading.equalTo(calanderImageView.snp.trailing).offset(5)
        }
    }
}
