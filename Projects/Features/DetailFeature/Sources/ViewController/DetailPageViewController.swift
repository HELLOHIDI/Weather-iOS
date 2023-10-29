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
    
    private var viewControllerList: [UIViewController] = [UIViewController]()
    
    //MARK: - UI Components
    
    private lazy var pageControl: UIPageControl = { createPageControl() }()
    private var pageViewController: UIPageViewController = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal)
    private lazy var pageControlBarItem: UIBarButtonItem = UIBarButtonItem(customView: pageControl)
    //    private let detailBottomView = DetailBottomView()
    
    
    public init(viewModel: DetailViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        bindUI()
        bindViewModel()
        
        delegate()
        
        style()
        hierarchy()
        layout()
    }
    
    
    func createPageControl() -> UIPageControl {
        let pageControl = UIPageControl()
        pageControl.numberOfPages = 3
        pageControl.currentPageIndicatorTintColor = .white
        pageControl.pageIndicatorTintColor = .white.withAlphaComponent(0.5)
        pageControl.setIndicatorImage(DSKitAsset.dot.image, forPage: 0)
        return pageControl
    }
    
    private func bindUI() {
        //        detailBottomView.listButton
        //            .rx.tap
        //            .subscribe(with: self, onNext: { owner, _ in
        //                owner.navigationController?.popViewController(animated: true)
        //            }).disposed(by: disposeBag)
    }
    
    private func bindViewModel() {
        let input = DetailViewModel.Input(
            viewWillAppearEvent: self.rx.viewWillAppear.asObservable()
        )
        
        let output = self.viewModel.transform(from: input, disposeBag: disposeBag)
        
        output.myPlaceWeatherList
            .asDriver(onErrorJustReturn: [])
            .drive(with: self, onNext: { owner, weatherList in
                for page in 0..<weatherList.count {
                    owner.viewControllerList.append(
                        DetailViewController(
                            forPK: page,
                            weatherData: weatherList[page]
                        )
                    )
                }
                owner.pageViewController.setViewControllers(
                    [owner.viewControllerList[owner.viewModel.getCurrentPage()]],
                    direction: .forward,
                    animated: true,
                    completion: nil
                )
            }).disposed(by: disposeBag)
        
    }
    
    private func delegate() {
        pageViewController.delegate = self
        pageViewController.dataSource = self
    }
    
    private func style() {
        self.navigationController?.navigationBar.isHidden = true
    }
    
    private func hierarchy() {
        self.view.addSubview(pageViewController.view)
    }
    
    private func layout() {
        pageViewController.view.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}

extension DetailPageViewController: UIPageViewControllerDelegate {
    public  func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        guard completed else { return }
        
        if let viewConroller = pageViewController.viewControllers?.first {
            pageControl.currentPage = viewControllerList.firstIndex(of: viewConroller) ?? 0
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
