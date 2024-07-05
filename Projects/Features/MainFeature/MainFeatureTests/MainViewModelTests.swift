//
//  MainFeatureTests.swift
//  MainFeatureTests
//
//  Created by 류희재 on 6/25/24.
//  Copyright © 2024 hellohidi. All rights reserved.
//

import XCTest

import RxRelay
import RxSwift
import MainFeature
import Domain
//import RxTest

final class MainViewModelTests: XCTestCase {
    private var viewModel: MainViewModel!
    private var scheduler:
    private var disposeBag: DisposeBag!
    private var input: MainViewModel.Input!
    private var output: MainViewModel.Output!
    private var mainUseCase: MainUseCase!
    
    override func setUpWithError() throws {
        self.mainUseCase = MockMainUseCase()
        self.viewModel = MainViewModel.init(
            mainCoordinator: nil,
            mainUseCase: mainUseCase
        )
        self.disposeBag = DisposeBag()
//        self.scheduler = TestScheduler(initialClock: 0)
    }
    
    override func tearDownWithError() throws {
        self.viewModel = nil
        self.disposeBag = nil
    }
}
