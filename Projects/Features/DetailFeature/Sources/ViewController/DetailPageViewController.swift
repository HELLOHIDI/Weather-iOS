//
//  DetailPageViewController.swift
//  DetailFeature
//
//  Created by 류희재 on 2023/10/29.
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

public final class DetailPageViewController: UIViewController {
    
    //MARK: - Properties
    
    public let viewModel: DetailViewModel
    private let disposeBag = DisposeBag()
    
    private let pagingSubject = PublishSubject<Int>()
    
    private var viewControllerList: [UIViewController] = [UIViewController]()
    
    //MARK: - UI Components
    
    private var pageViewController: UIPageViewController = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal)
    private let detailBottomView = DetailBottomView()
    
    
    public init(viewModel: DetailViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        bindViewModel()
        
        setDelegate()
        
        style()
        hierarchy()
        layout()
    }
    
    private func bindViewModel() {
        let input = DetailViewModel.Input(
            listButtonDidTapEvent: detailBottomView.listButton.rx.tap.asObservable(),
            pagingEvent: pagingSubject.asObservable()
        )
        
        let output = self.viewModel.transform(from: input, disposeBag: disposeBag)
        
        output.myPlaceWeatherList
            .asDriver(onErrorJustReturn: [])
            .drive(with: self, onNext: { owner, weatherList in
                owner.updatePageViewController(weatherList)
                owner.updatePageControl(weatherList.count)
            }).disposed(by: disposeBag)
        
        output.currentPage
            .asDriver(onErrorJustReturn: Int())
            .drive(with: self, onNext: { owner, currnetPage in
                owner.detailBottomView.pageControl.currentPage = currnetPage
            }).disposed(by: disposeBag)
    }
    
    private func setDelegate() {
        pageViewController.delegate = self
        pageViewController.dataSource = self
    }
    
    private func style() {
        self.navigationController?.navigationBar.isHidden = true
    }
    
    private func hierarchy() {
        self.view.addSubviews(
            pageViewController.view,
            detailBottomView
        )
    }
    
    private func layout() {
        pageViewController.view.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        detailBottomView.snp.makeConstraints {
            $0.bottom.equalToSuperview()
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(82.adjusted)
        }
    }
}

extension DetailPageViewController: UIPageViewControllerDelegate {
    public  func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        guard completed else { return }
        
        if let viewConroller = pageViewController.viewControllers?.first {
            pagingSubject.onNext(viewControllerList.firstIndex(of: viewConroller) ?? 0)
        }
    }
}

// MARK: - UIPageViewControllerDataSource

extension DetailPageViewController: UIPageViewControllerDataSource {
    public  func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        if let index = viewControllerList.firstIndex(of: viewController), index > 0 {
            return viewControllerList[index - 1]
        } else { return nil }
    }
    
    public  func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        if let index = viewControllerList.firstIndex(of: viewController), index < viewControllerList.count - 1 {
            return viewControllerList[index + 1]
        } else { return nil }
    }
}

extension DetailPageViewController {
    func updatePageViewController(_ weatherList: [WeatherModel]) {
        for page in 0..<weatherList.count {
            self.viewControllerList.append(
                DetailViewController(
                    forPK: page,
                    weatherData: weatherList[page]
                )
            )
        }
        self.pageViewController.setViewControllers(
            [self.viewControllerList[self.viewModel.getCurrentPage()]],
            direction: .forward,
            animated: true,
            completion: nil
        )
    }
    
    func updatePageControl(_ cnt: Int) {
        self.detailBottomView.pageControl.numberOfPages = cnt
        self.detailBottomView.pageControl.setIndicatorImage(DSKitAsset.navigator.image, forPage: 0)
    }
}
