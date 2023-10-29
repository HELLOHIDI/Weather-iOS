//
//  DetailViewController.swift
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
import RxSwift
import RxGesture
import RxCocoa

public final class DetailViewController : UIViewController {
    
    //MARK: - Properties
    
    private var _weatherModelPrimaryKey: Int?
        private var _weatherData: WeatherModel?
        
        var weatherModelPrimaryKey: Int? {
            get {
                return _weatherModelPrimaryKey
            }
            set {
                _weatherModelPrimaryKey = newValue
                dump(_weatherModelPrimaryKey)
            }
        }
        
        var weatherData: WeatherModel? {
            get {
                return _weatherData
            }
            set {
                _weatherData = newValue
                dump(_weatherData)
                rootView.dataBind(_weatherData)
            }
        }
    
    //MARK: - UI Components
    
    let rootView = DetailView()
    
    //MARK: - Life Cycle
    
    init(forPK: Int, weatherData: WeatherModel) {
        super.init(nibName: nil, bundle: nil)
        self.weatherData = weatherData
        self.weatherModelPrimaryKey = forPK

        print("\(forPK)번째 도시는 \(weatherData.place)")
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func loadView() {
        self.view = rootView
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
    }
}
