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
        delegate()
    }
    
    private func updateUI() {
        rootView.detaiHourlyWeatherView.hourlyCollectionView.reloadData()
        rootView.detailTopView.updateUI(weatherData)
    }
    
    private func delegate() {
        rootView.detaiHourlyWeatherView.hourlyCollectionView.dataSource = self
    }
}

extension DetailViewController: UICollectionViewDataSource {
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return weatherData.hourlyWeatherData.count
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DetailHourlyCollectionViewCell.cellIdentifier, for: indexPath) as! DetailHourlyCollectionViewCell
        cell.dataBind(weatherData.hourlyWeatherData[indexPath.item])
        return cell
    }
}
