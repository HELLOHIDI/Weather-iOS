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

import SnapKit
import Then

final class DetailView: UIView {
    
    // MARK: - Properties
    
    public let detailCollectionView = UICollectionView(frame: .zero, collectionViewLayout: .init())
    
    // MARK: - Life Cycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        register()
        
        style()
        hieararchy()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func register() {
        detailCollectionView.register(
            DetailWeatherCollectionViewCell.self, forCellWithReuseIdentifier: DetailWeatherCollectionViewCell.cellIdentifier
        )
    }
    
    private func style() {
        detailCollectionView.do {
            let layout = UICollectionViewFlowLayout()
            layout.scrollDirection = .horizontal
            layout.itemSize = CGSize(
                width: UIScreen.main.bounds.width,
                height: UIScreen.main.bounds.height
            )
            layout.minimumLineSpacing = 0
            layout.minimumInteritemSpacing = 0
            
            $0.collectionViewLayout = layout
            $0.backgroundColor = .clear
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.isScrollEnabled = true
        }
    }
    
    private func hieararchy() {
        self.addSubview(detailCollectionView)
    }
    
    private func layout() {
        detailCollectionView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}
