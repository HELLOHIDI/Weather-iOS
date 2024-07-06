//
//  MainViewController.swift
//  MainFeature
//
//  Created by 류희재 on 2023/10/23.
//  Copyright © 2023 baegteun. All rights reserved.
//

import UIKit

import Domain
import DSKit

import SnapKit
import Then
import RxSwift
import RxGesture
import RxCocoa
import BaseFeatureDependency
import MainFeatureInterface

public final class MainViewController: UIViewController, MainViewControllable {
    //MARK: - Properties
    
    public var viewModel: MainViewModel
    private let disposeBag = DisposeBag()
    
    public let searchBarDidChangeSubject = PublishSubject<String>()
    
    //MARK: - UI Components
    
    let rootView = MainView()
    
    private lazy var seeMoreButton = UIBarButtonItem()
    private lazy var weatherSearchController =  UISearchController(searchResultsController: nil)
    
    //MARK: - Life Cycle
    
    public init(viewModel: MainViewModel) {
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
        
        style()
        setDelegate()
        
        bindViewModel()
    }
    
    //MARK: - Custom Method
    
    private func style() {
        navigationItem.do {
            $0.title = "날씨"
            $0.rightBarButtonItem = seeMoreButton
            $0.searchController = weatherSearchController
            $0.hidesSearchBarWhenScrolling = false
        }
        
        self.navigationController?.navigationBar.do {
            $0.barTintColor = .black.withAlphaComponent(0.75)
            $0.prefersLargeTitles = true
            $0.titleTextAttributes = [.foregroundColor: UIColor.white]
            $0.largeTitleTextAttributes = [
                .foregroundColor: UIColor.white,
                .font: DSKitFontFamily.SFProDisplay.bold.font(size: 36)]
        }
        
        seeMoreButton.do {
            $0.image = DSKitAsset.menu.image
            $0.tintColor = .white
        }
        
        weatherSearchController.searchBar.do {
            $0.searchTextField.setPlaceholderColor(
                text: "도시 또는 공항 검색",
                color: .lightGray
            )
            $0.barTintColor = .black
            $0.tintColor = .white
            $0.searchTextField.backgroundColor = .darkGray
            $0.setValue("취소", forKey: "cancelButtonText")
            $0.setImage(DSKitAsset.search.image, for: .search, state: .normal)
        }
        
        weatherSearchController.searchBar.searchTextField.textColor = .white
    }
    
    private func setDelegate() {
        weatherSearchController.searchResultsUpdater = self
    }
    
    private func bindViewModel() {
        let input = MainViewModel.Input(
            viewWillAppearEvent: self.rx.viewWillAppear.asObservable(),
            weatherListViewDidTapEvent: rootView.weatherView.rx.itemSelected.asObservable(),
            searchBarDidChangeEvent: searchBarDidChangeSubject.asObservable()
        )
        
        let output = self.viewModel.transform(from: input, disposeBag: disposeBag)
        
        output.weatherList
            .asDriver(onErrorJustReturn: [])
            .drive(self.rootView.weatherView.rx.items(
                cellIdentifier: MainWeatherCollectionViewCell.cellIdentifier,
                cellType: MainWeatherCollectionViewCell.self)
            ) { _, data, cell in
                cell.dataBind(data)
            }.disposed(by: disposeBag)
    }
}

extension MainViewController: UISearchResultsUpdating {
    public func updateSearchResults(for searchController: UISearchController) {
        searchBarDidChangeSubject.onNext(searchController.searchBar.text ?? "")
    }
}
