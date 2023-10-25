//
//  DetailViewController.swift
//  DetailFeature
//
//  Created by 류희재 on 2023/10/25.
//  Copyright © 2023 hellohidi. All rights reserved.
//

import UIKit
import Domain

import SnapKit
import Then
import RxSwift
import RxGesture
import RxCocoa

public final class DetailViewController : UIViewController {
    
    //MARK: - Properties
    
    public let viewModel: DetailViewModel
    private let disposeBag = DisposeBag()
    
    let rootView = DetailView()
    
    //MARK: - UI Components
    
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
        
        bindUI()
        bindViewModel()
    }
    
    private func bindUI() {
    }
    
    private func bindViewModel() {
        let input = DetailViewModel.Input()
        
        let output = self.viewModel.transform(from: input, disposeBag: disposeBag)
        
        output.hourlyWeatherList
            .asDriver(onErrorJustReturn: [])
            .drive(with: self, onNext: { owner, weatherList in
                owner.updateUI(weatherList)
            }).disposed(by: disposeBag)
    }
    
    private func updateUI(_ weatherList: [WeatherHourlyModel]) {
        (0..<weatherList.count).enumerated().map { index, _ in
            let weatherListView = DetailHourlyStackView()
            weatherListView.dataBind(weatherList[index])
            return weatherListView
        }.forEach(rootView.detaiHourlyWeatherView.stackView.addArrangedSubview)
    }
    
}
