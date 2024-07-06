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
import Networks
import Data
import BaseFeatureDependency
import DetailFeatureInterface

import SnapKit
import Then
import RxSwift
import RxGesture
import RxCocoa


public final class DetailPageViewController: UIViewController, DetailPresentable {
    //MARK: - Properties
    
    public var listButtonDidTap: (() -> Void)?
    
    private let disposeBag = DisposeBag()
    
    private let pagingSubject = PublishSubject<Int>()
    
    var currentPage: Int
    private var viewControllerList: [UIViewController] = [UIViewController]()
    
    //MARK: - UI Components
    
    private var pageViewController: UIPageViewController = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal)
    private let detailBottomView = DetailBottomView()
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Life Cycle
    
    public init(currentPage: Int) {
        self.currentPage = currentPage
        super.init(nibName: nil, bundle: nil)
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        bindUI()
        
        setDelegate()
        
        style()
        hierarchy()
        layout()
    }
    
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        updatePageViewController()
        updatePageControl()
    }
    
    private func bindUI() {
        detailBottomView.listButton.rx.tap
            .subscribe(with: self, onNext: { owner, _ in
                owner.listButtonDidTap?()
            }).disposed(by: disposeBag)
        
        pagingSubject
            .subscribe(with: self, onNext: { owner, currentPage in
                owner.detailBottomView.pageControl.currentPage = currentPage
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
    func updatePageViewController() {
        for city in City.cityList {
            self.viewControllerList.append(
                DetailViewController(
                    viewModel: DetailViewModel(
                        detailUseCase: DefaultDetailUseCase(
                            city: city,
                            repository: DefaultWeatherRepository(
                                urlSessionService: WeatherNetworkService()
                                )
                        )
                    )
                )
            )
        }
        self.pageViewController.setViewControllers(
            [self.viewControllerList[currentPage]],
            direction: .forward,
            animated: true,
            completion: nil
        )
    }
    
    func updatePageControl() {
        self.detailBottomView.pageControl.numberOfPages = City.cityList.count
        self.detailBottomView.pageControl.setIndicatorImage(DSKitAsset.navigator.image, forPage: 0)
    }
}
