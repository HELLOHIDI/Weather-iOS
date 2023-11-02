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

public final class DetailViewController : UIViewController {
    
    //MARK: - Properties
    
    private var weatherModelPrimaryKey: Int?
    private var weatherData: WeatherModel
    
    private let disposeBag = DisposeBag()
    
    var sectionSubject = BehaviorRelay(value: [SectionData<WeatherForecastModel>]())
    private var weatherForecastDataSource: RxCollectionViewSectionedReloadDataSource<SectionData<WeatherForecastModel>>?
    
    
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
        setDelegate()
        
        configureDataSource()
        configureCollectionView()
        
        bindViewModel()
    }
    
    private func updateUI() {
        rootView.detailTopView.updateUI(weatherData)
        rootView.detailStickyHeaderView.updateUI(weatherData)
    }
    
    private func setDelegate() {
        rootView.scrollView.delegate = self
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
        weatherData.hourlyWeatherData
            .asDriver(onErrorJustReturn: [])
            .drive(
                self.rootView.detailHourlyWeatherView.hourlyCollectionView.rx.items(
                    cellIdentifier: DetailHourlyCollectionViewCell.cellIdentifier,
                    cellType: DetailHourlyCollectionViewCell.self)
            ) { _, data, cell in
                cell.dataBind(data)
            }.disposed(by: disposeBag)
        
        weatherData.weatherForecastData
            .subscribe(with: self, onNext: { owner, forecastData in
                var updateSection: [SectionData<WeatherForecastModel>] = []
                updateSection.append(SectionData<WeatherForecastModel>(items: forecastData))
                owner.sectionSubject.accept(updateSection)
            }).disposed(by: disposeBag)
        
        weatherData.weatherForecastData
            .asDriver(onErrorJustReturn: [])
            .drive(with: self, onNext: { owner, weatherData in
                owner.rootView.updateLayout(weatherData.count)
            }).disposed(by: disposeBag)
    }
}

extension DetailViewController: UIScrollViewDelegate {
    public func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let alpha1 = 1.0 - ((scrollView.contentOffset.y - 30) / 40 )
        let alpha2 = 1.0 - ((scrollView.contentOffset.y - 70) / 40 )
        let alpha3 = 1.0 - ((scrollView.contentOffset.y - 110) / 40 )
        let alpha4 = 1.0 - ((scrollView.contentOffset.y - 150) / 40 )
        print("현재위치 \(scrollView.contentOffset.y)")
        switch scrollView.contentOffset.y {
        case 30..<70:
            print("🍎 \(alpha1)")
            rootView.detailTopView.maxmimTemparatureLabel.alpha = alpha1
        case 70..<110:
            print("🍏 \(alpha2)")
            rootView.detailTopView.weatherLabel.alpha = alpha2
        case 110..<150:
            print("🍗 \(alpha3)")
            rootView.detailTopView.temparatureLabel.alpha = alpha3
        case 150...:
            print("🦖 \(alpha4)")
            rootView.detailStickyHeaderView.isHidden = false
            rootView.detailTopView.placeLabel.alpha = alpha4
        default:
            break
        }
        
        
        //        rootView.detailTopView.alpha = alpha
        //        rootView.detailTopView.maxmimTemparatureLabel.alpha = alpha
        //        rootView.detailStickyHeaderView.alpha = 1 - alpha
        
//        print(rootView.detailTopView.frame.minY)
//        print(rootView.detailTopView.placeLabel.frame.minY)
//        print(rootView.detailTopView.temparatureLabel.frame.minY)
//        print(rootView.detailTopView.weatherLabel.frame.minY)
//        print(rootView.detailTopView.maxmimTemparatureLabel.frame.minY)
        
    }
}
