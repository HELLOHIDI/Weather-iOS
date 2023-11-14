//
//  DetailForecastWeatherView.swift
//  DetailFeature
//
//  Created by 류희재 on 2023/11/02.
//  Copyright © 2023 hellohidi. All rights reserved.
//

import UIKit

import Core
import DSKit

import SnapKit
import Then

final class DetailForecastView: UICollectionView {
    
    // MARK: - Life Cycle
    
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: .zero, collectionViewLayout: .init())
        
        register()
        
        style()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Custom Method
    
    private func register() {
        self.register(
            DetailForecastCollectionViewCell.self,
            forCellWithReuseIdentifier: DetailForecastCollectionViewCell.cellIdentifier
        )
        
        self.register(
            DetailForecastHeaderView.self,
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: DetailForecastHeaderView.reuseCellIdentifier
        )
    }
    
    private func style() {
        self.do {
            let layout = UICollectionViewFlowLayout()
            layout.itemSize = CGSize(
                width: 335,
                height: 55
            )
            layout.minimumLineSpacing = 0
            layout.minimumInteritemSpacing = 0
            layout.headerReferenceSize = CGSize(
                width: 335,
                height: 38
            )
            
            $0.collectionViewLayout = layout
            $0.backgroundColor = UIColor(red: 0.17, green: 0.2, blue: 0.25, alpha: 1)
            $0.makeCornerRound(radius: 15)
            $0.setBorder(borderWidth: 0.5, borderColor: .white.withAlphaComponent(0.25))
            $0.isScrollEnabled = false
        }
    }
}





