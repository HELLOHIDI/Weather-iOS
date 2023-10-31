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

final class MainWeatherView: UICollectionView {
    
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
            MainWeatherCollectionViewCell.self,
            forCellWithReuseIdentifier: MainWeatherCollectionViewCell.cellIdentifier
        )
    }
    private func style() {
        self.do {
            let layout = UICollectionViewFlowLayout()
            layout.scrollDirection = .horizontal
            layout.itemSize = CGSize(
                width: 355.adjusted,
                height: 117.adjusted
            )
            layout.minimumLineSpacing = 16
            layout.minimumInteritemSpacing = 0
            
            $0.collectionViewLayout = layout
            $0.backgroundColor = .clear
        }
    }
}
