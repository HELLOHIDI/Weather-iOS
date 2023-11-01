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
    
    private var weatherModelPrimaryKey: Int?
    private var weatherData: WeatherModel
    private let disposeBag = DisposeBag()
    
    //MARK: - UI Components
    
    let rootView = DetailView()
    
    //MARK: - Life Cycle
    
    init(forPK: Int, weatherData: WeatherModel) {
        self.weatherData = weatherData
        self.weatherModelPrimaryKey = forPK
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func loadView() {
        self.view = rootView
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        updateUI()
        
        bindViewModel()
    }
    
    private func updateUI() {
        rootView.detailTopView.updateUI(weatherData)
    }
    
    private func bindViewModel() {
        weatherData.hourlyWeatherData
            .asDriver(onErrorJustReturn: [])
            .drive(
                self.rootView.detaiHourlyWeatherView.hourlyCollectionView.rx.items(
                    cellIdentifier: DetailHourlyCollectionViewCell.cellIdentifier,
                    cellType: DetailHourlyCollectionViewCell.self)
            ) { _, data, cell in
                cell.dataBind(data)
            }.disposed(by: disposeBag)
        
        weatherData.weatherForecastData
            .asDriver(onErrorJustReturn: [])
            .drive(
                self.rootView.detailForecastWeatherView.rx.items(
                    cellIdentifier: DetailForecastWeatherViewCell.cellIdentifier,
                    cellType: DetailForecastWeatherViewCell.self)
            ) { _, data, cell in
                cell.dataBind(data)
            }.disposed(by: disposeBag)
    }
}
