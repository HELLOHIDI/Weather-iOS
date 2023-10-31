//
//  DetailViewController.swift
//  DetailFeature
//
//  Created by 류희재 on 2023/10/25.
//  Copyright © 2023 hellohidi. All rights reserved.
//

import UIKit

import Core
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
    
    private let scrollEventSubject = PublishSubject<Int>()
    
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
        
        style()
        delegate()
        
        bindUI()
        bindViewModel()
    }
    
    private func style() {
        self.navigationController?.navigationBar.isHidden = true
    }
    
    private func delegate() {
        rootView.detailCollectionView.delegate = self
    }
    
    private func bindUI() {
        rootView.detailBottomView.listButton
            .rx.tap
            .subscribe(with: self, onNext: { owner, _ in
                owner.navigationController?.popViewController(animated: true)
            }).disposed(by: disposeBag)
    }
    
    private func bindViewModel() {
        let input = DetailViewModel.Input(
            viewWillAppearEvent: self.rx.viewWillAppear.asObservable(),
            scrollEvent: scrollEventSubject.asObservable()
        )
        
        let output = self.viewModel.transform(from: input, disposeBag: disposeBag)
        
        output.myPlaceWeatherList
            .asDriver(onErrorJustReturn: [])
            .drive(self.rootView.detailCollectionView.rx.items) { collectionView, index, data in
                collectionView.setContentOffset(
                    CGPoint(
                        x: self.viewModel.getCurrentPage() * UIScreen.main.bounds.width,
                        y: -59.adjusted
                    ),
                    animated: true
                )
                
                let cell = collectionView.dequeueReusableCell(
                    withReuseIdentifier: DetailWeatherCollectionViewCell.cellIdentifier,
                    for: IndexPath(item: index, section: 0)) as! DetailWeatherCollectionViewCell
                cell.dataBind(data)
                return cell
            }.disposed(by: disposeBag)
        
        output.weatherIndicatorList
            .asDriver(onErrorJustReturn: [])
            .drive(with: self, onNext: { owner, indicatorList in
                owner.rootView.detailBottomView.updateLayout(indicatorList.count)
            }).disposed(by: disposeBag)
        
        output.weatherIndicatorList
            .asDriver(onErrorJustReturn: [])
            .drive(self.rootView.detailBottomView.indicatorCollectionView.rx.items) { collectionView, index, data in
                print(data)
                let cell = collectionView.dequeueReusableCell(
                    withReuseIdentifier: DetailIndicatorCollectionViewCell.cellIdentifier,
                    for: IndexPath(item: index, section: 0)) as! DetailIndicatorCollectionViewCell
                cell.updateUI(index, data)
                return cell
            }.disposed(by: disposeBag)
    }
}

extension DetailViewController: UICollectionViewDelegate {
    public func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let layout = self.rootView.detailCollectionView.collectionViewLayout as! UICollectionViewFlowLayout
        
        var offset = targetContentOffset.pointee
        let index = (offset.x + scrollView.contentInset.left) / layout.itemSize.width
        var roundedIndex = round(index)
        
        if scrollView.contentOffset.x > targetContentOffset.pointee.x {
            roundedIndex = floor(index)
        } else if scrollView.contentOffset.x < targetContentOffset.pointee.x {
            roundedIndex = ceil(index)
        } else {
            roundedIndex = round(index)
        }
        
        var currentPage = self.viewModel.getCurrentPage()
        if currentPage > roundedIndex {
            currentPage -= 1
            roundedIndex = currentPage
        } else if currentPage < roundedIndex {
            currentPage += 1
            roundedIndex = currentPage
        }
        
        offset = CGPoint(
            x: roundedIndex * layout.itemSize.width - scrollView.contentInset.left,
            y: 0
        )
        targetContentOffset.pointee = offset
        scrollEventSubject.onNext(Int(currentPage))
    }
}
