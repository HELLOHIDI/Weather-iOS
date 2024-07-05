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
import RxCocoa
import RxDataSources
import BaseFeatureDependency
import DetailFeatureInterface

public final class DetailViewController : UIViewController, DetailViewControllable {
    
    //MARK: - Properties
    
    public var viewModel: DetailViewModel
    
    private let disposeBag = DisposeBag()
    
    var sectionSubject = BehaviorRelay(value: [SectionData<WeatherForecastModel>]())
    private var weatherForecastDataSource: RxCollectionViewSectionedReloadDataSource<SectionData<WeatherForecastModel>>?
    private let weatherForcastData: BehaviorRelay<[WeatherForecastModel]> = BehaviorRelay(value: WeatherForecastModel.weatherForecastData)
    
    
    //MARK: - UI Components
    
    let rootView = DetailView()
    
    //MARK: - Life Cycle
    
    public init(viewModel: DetailViewModel) {
        self.viewModel = viewModel
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
        
        configureDataSource()
        configureCollectionView()
        
        bindViewModel()
    }
    
    private func configureDataSource() {
        weatherForecastDataSource = RxCollectionViewSectionedReloadDataSource<SectionData<WeatherForecastModel>>(
            configureCell: { dataSource, collectionView, indexPath, data in
                let cell = collectionView.dequeueReusableCell(
                    withReuseIdentifier: DetailForecastCollectionViewCell.cellIdentifier,
                    for: indexPath
                ) as! DetailForecastCollectionViewCell
                cell.dataBind(data)
                return cell
            },configureSupplementaryView: { (dataSource, collectionView, kind, indexPath) -> UICollectionReusableView in
                let kind = UICollectionView.elementKindSectionHeader
                let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: DetailForecastHeaderView.reuseCellIdentifier, for: indexPath) as! DetailForecastHeaderView
                return header
            })
    }
    
    func configureCollectionView() {
        guard let weatherForecastDataSource else { return }
        sectionSubject
            .bind(to: rootView.detailForecastWeatherView.rx.items(dataSource: weatherForecastDataSource))
            .disposed(by: disposeBag)
    }
    
    private func bindViewModel() {
        let input = DetailViewModel.Input(
            viewWillAppearEvent: self.rx.viewWillAppear.asObservable()
        )
        
        let output = self.viewModel.transform(from: input, disposeBag: disposeBag)
        
        output.currentWeatherData
            .subscribe(with: self, onNext: { owner, weatherData in
                owner.rootView.detailTopView.updateUI(weatherData)
            }).disposed(by: disposeBag)
        
        output.hourlyWeatherData
            .asDriver(onErrorJustReturn: [])
            .drive(self.rootView.detailHourlyWeatherView.hourlyCollectionView.rx.items(
                cellIdentifier: DetailHourlyCollectionViewCell.cellIdentifier,
                cellType: DetailHourlyCollectionViewCell.self)
            ) { _, data, cell in
                cell.dataBind(data)
            }.disposed(by: disposeBag)
        
        weatherForcastData
            .subscribe(with: self, onNext: { owner, forecastData in
                var updateSection: [SectionData<WeatherForecastModel>] = []
                updateSection.append(SectionData<WeatherForecastModel>(items: forecastData))
                owner.sectionSubject.accept(updateSection)
            }).disposed(by: disposeBag)
        
        weatherForcastData
            .asDriver(onErrorJustReturn: [])
            .drive(with: self, onNext: { owner, weatherData in
                owner.rootView.updateLayout(weatherData.count)
            }).disposed(by: disposeBag)
    }
}
