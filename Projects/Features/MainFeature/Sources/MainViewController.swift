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
import DetailFeature

import SnapKit
import Then
import RxSwift
import RxGesture
import RxCocoa

public final class MainViewController : UIViewController {
    
    //MARK: - Properties
    
    public let viewModel: MainViewModel
    private let disposeBag = DisposeBag()
    
    public let searchBarDidChangeSubject = PublishSubject<String>()
    
    let rootView = MainView()
    
    //MARK: - UI Components
    
    private lazy var seeMoreButton = UIBarButtonItem()
    private lazy var weatherSearchController: UISearchController = { createWeatherSearchBar() }()
    
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
        
        bindUI()
        bindViewModel()
    }
    
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.navigationBar.isHidden = false
    }
    
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
        
        weatherSearchController.searchBar.searchTextField.textColor = .white
    }
    
    private func bindUI() {
    }
    
    private func bindViewModel() {
        let input = MainViewModel.Input(
            searchBarDidChangeEvent: searchBarDidChangeSubject.asObservable()
        )
        
        let output = self.viewModel.transform(from: input, disposeBag: disposeBag)
        
        output.weatherList
            .asDriver(onErrorJustReturn: [])
            .drive(with: self, onNext: { owner, weatherList in
                owner.updateUI(weatherList)
            }).disposed(by: disposeBag)
    }
    
    //MARK: - Custom Method
    
    private func updateUI(_ weatherList: [WeatherModel]) {
        for subview in rootView.weatherView.stackView.arrangedSubviews {
            rootView.weatherView.stackView.removeArrangedSubview(subview)
            subview.removeFromSuperview()
        }
        
        (0..<weatherList.count).enumerated().map { index, _ in
            let weatherListView = MainWeatherListView()
            weatherListView.delegate = self
            weatherListView.dataBind(index, weatherList[index])
            return weatherListView
        }.forEach(rootView.weatherView.stackView.addArrangedSubview)
    }
    
    func createWeatherSearchBar() -> UISearchController {
        let searchController = UISearchController(searchResultsController: nil)
        searchController.searchBar
            .searchTextField
            .setPlaceholderColor(color: .darkGray)
        
        searchController.searchBar.barTintColor = .black                                // contentsView Color
        searchController.searchBar.tintColor = .white                                   // cancleButton Color
        searchController.searchBar.searchTextField.backgroundColor = .darkGray
        searchController.searchBar.setValue("취소", forKey: "cancelButtonText")
        searchController.searchBar.setImage(DSKitAsset.search.image, for: .search, state: .normal)
        searchController.searchResultsUpdater = self
        
        return searchController
    }
}

extension MainViewController: MainViewWeatherListDelegate {
    func weatherViewDidTap(_ tag: Int) {
        let detailVC = DetailViewController(
            viewModel: DetailViewModel(
                detailUseCase: DefaultDetailUseCase.init(
                    tag,
                    viewModel.getWeatherList()
                )
            )
        )
        self.navigationController?.pushViewController(detailVC, animated: true)
    }
}

extension MainViewController: UISearchResultsUpdating {
    public func updateSearchResults(for searchController: UISearchController) {
        searchBarDidChangeSubject.onNext(searchController.searchBar.text ?? "")
    }
}

