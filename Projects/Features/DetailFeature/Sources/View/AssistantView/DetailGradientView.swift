//
//  DetailGradientView.swift
//  DetailFeature
//
//  Created by 류희재 on 2023/11/17.
//  Copyright © 2023 hellohidi. All rights reserved.
//

import UIKit

import SnapKit

class DetailGradientView: UIView {
    
    // MARK: - Properties
    
    private let staticHighestTemp: Int = 50    // 세상에서 제일 높은 온도..
    private let staticLowestTemp: Int = -50    // 세상에서 제일 낮은 온도..
    private var widthOfBar: CGFloat
    
    private var highestTemp: Int?    // 10일간의 날씨 중 가장 높은 온도
    private var lowestTemp: Int?     // 10일간의 날씨 중 가장 낮은 온도
    
    // MARK: - UI Properties
    
    private let gradientView: UIView = UIView()
    private let gradientImageView: UIImageView = UIImageView()
    
    override init(frame: CGRect) {
        widthOfBar = frame.width
        
        super.init(frame: frame)
        
        setupStyle()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension DetailGradientView {
    /// 당일 날씨의 가장 높은 온도와 가장 낮은 온도를 받아,
    /// 10일간의 가장 높고 낮은 온도의 비율을 계산해서 layer에 mask를 씌워주는 함수
    func setupDaysGradient(daysHighestTemp: Int, daysLowestTemp: Int) {
        if let highestTemp = highestTemp, let lowestTemp = lowestTemp {
            let lengthRaio = widthOfBar / CGFloat(highestTemp - lowestTemp)
            let leftInset  = CGFloat(daysLowestTemp - lowestTemp) * lengthRaio
            let rightInset = CGFloat(highestTemp - daysHighestTemp) * lengthRaio
            let width = widthOfBar - leftInset - rightInset
            
            
            gradientImageView.roundedMask(rect: .init(x: leftInset, y: 0, width: width, height: 4))
        }
    }
    
    /// GradientView를 만들어준 뒤 10일간의 날씨 중 가장 높고 낮은 온도의 비율에 맞춰,
    /// 색에 맞는 GradientView를 UIImage로 만들어주는 함수
    func setupGradient(forTendaysHighestTemp: Int, forTendaysLowestTemp: Int) {
        highestTemp = forTendaysHighestTemp
        lowestTemp = forTendaysLowestTemp
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = self.bounds
        
        let colors: [CGColor] = [UIColor.systemBlue.cgColor,
                                 UIColor.systemCyan.cgColor,
                                 UIColor.systemCyan.cgColor,
                                 UIColor.systemCyan.cgColor,
                                 UIColor.systemYellow.cgColor,
                                 UIColor.systemOrange.cgColor,
                                 UIColor.systemRed.cgColor]
        
        gradientLayer.colors = colors
        
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.0)
        gradientLayer.endPoint = CGPoint(x: 1.0, y: 0.0)
        
        gradientView.layer.addSublayer(gradientLayer)
        
        let leftInset = forTendaysLowestTemp - staticLowestTemp
        let rightInset = staticHighestTemp - forTendaysHighestTemp
        gradientImageView.image = gradientView.asImage(rect: self.bounds.inset(by: .init(top: 0, left: CGFloat(leftInset), bottom: 0, right: CGFloat(rightInset))))
    }
}

private extension DetailGradientView {
    
    func setupStyle() {
        backgroundColor = .black.withAlphaComponent(0.4)
        makeCornerRound(radius: 2)
    }
    
    func setupLayout() {
        self.snp.makeConstraints {
            $0.width.equalTo(self.frame.width)
            $0.height.equalTo(4)
        }
        
        addSubview(gradientImageView)
        
        gradientImageView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}
    
