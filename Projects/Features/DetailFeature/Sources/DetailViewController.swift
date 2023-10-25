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
    
    let rootView = DetailView()
    
    var previousOffset: CGFloat = 0
        var currentPage: Int = 0
    
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
    
    private func bindUI() {}
    
    private func bindViewModel() {
        let input = DetailViewModel.Input()
        
        let output = self.viewModel.transform(from: input, disposeBag: disposeBag)
        
        //        output.hourlyWeatherList
        //            .asDriver(onErrorJustReturn: [])
        //            .drive(with: self, onNext: { owner, weatherList in
        //                owner.updateUI(weatherList)
        //            }).disposed(by: disposeBag)
        
        output.myPlaceWeatherList
            .asDriver(onErrorJustReturn: [])
            .drive(self.rootView.detailCollectionView.rx.items) { collectionView, index, data in
                let cell = collectionView.dequeueReusableCell(
                    withReuseIdentifier: DetailWeatherCollectionViewCell.cellIdentifier,
                    for: IndexPath(item: index, section: 0)) as! DetailWeatherCollectionViewCell
                cell.dataBind(data)
                return cell
            }.disposed(by: disposeBag)
    }
}

extension DetailViewController: UICollectionViewDelegate {
    public func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let point = self.targetContentOffset(scrollView, withVelocity: velocity)
        targetContentOffset.pointee = point
        
        UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: velocity.x, options: .allowUserInteraction, animations: {
            self.rootView.detailCollectionView.setContentOffset(point, animated: true)
        }, completion: nil)
    }
    
    func targetContentOffset(_ scrollView: UIScrollView, withVelocity velocity: CGPoint) -> CGPoint {
        
        let flowLayout = rootView.detailCollectionView.collectionViewLayout as! UICollectionViewFlowLayout
        
        if previousOffset > rootView.detailCollectionView.contentOffset.x && velocity.x < 0 {
            currentPage = currentPage - 1
        } else if previousOffset < rootView.detailCollectionView.contentOffset.x && velocity.x > 0 {
            currentPage = currentPage + 1
        }
        
        let additional = (flowLayout.itemSize.width + flowLayout.minimumLineSpacing) - flowLayout.headerReferenceSize.width
        
        let updatedOffset = (flowLayout.itemSize.width + flowLayout.minimumLineSpacing) * CGFloat(currentPage) - additional
        
        previousOffset = updatedOffset
        
    
        return CGPoint(x: updatedOffset, y: 0)
    }
}


