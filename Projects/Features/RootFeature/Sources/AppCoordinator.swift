//
//  AppCoordinator.swift
//  ProjectDescriptionHelpers
//
//  Created by 류희재 on 2023/10/30.
//

import UIKit

import Core
import BaseFeatureDependency
import MainFeature
import DetailFeature

public class AppCoordinator: BaseCoordinator {
    private let router: Router
    
    public init(router: Router) {
        self.router = router
        
        super.init()
    }
    
    public override func start() {
        runMainFlow()
    }
}

extension AppCoordinator {
    private func runMainFlow() {
        self.childCoordinators = []
        
        let coordinator = MainCoordinator(
            router: router,
            factory: MainBuilder()
        )
        coordinator.requestCoordinating = { [weak self] /*destination in*/  in
            self?.runDetailFlow()
            //            switch destination {
            //            case .myPage(let userType):
            //                self?.runMyPageFlow(of: userType)
            //            case .notification:
            //                self?.runNotificationFlow()
            //            case .attendance:
            //                self?.runAttendanceFlow()
            //            case .stamp:
            //                self?.runStampFlow()
            //            case .poke:
            //                self?.runPokeFlow()
            //            case .pokeOnboarding:
            //                self?.runPokeOnboardingFlow()
            //            case .signIn:
            //                self?.runSignInFlow(by: .rootWindow(animated: true, message: nil))
            //                self?.removeDependency(coordinator)
            //            }
        }
        addDependency(coordinator)
        coordinator.start()
//        coordinator.start(by: .rootWindow(animated: false, message: nil))
    }
    
    @discardableResult
    internal func runDetailFlow() -> DetailCoordinator {
        let coordinator = DetailCoordinator(
            router: Router(
                rootController: UIWindow.getRootNavigationController
            ),
            factory: DetailBuilder()
        )
        coordinator.finishFlow = { [weak self, weak coordinator] in
            self?.removeDependency(coordinator)
        }
        addDependency(coordinator)
        coordinator.start()
        
        return coordinator
    }
}

//public class AppCoordinator: Coordinator {
//
//    public var childCoordinators: [Coordinator] = []
//    public var navigationController: UINavigationController
//
//    public init(navigationController: UINavigationController!) {
//        self.navigationController = navigationController
//    }
//
//    public func start() {
//        showMainViewController()
//    }
//
//    private func showMainViewController() {
//        let coordinator = DefaultMainCoordinator(navigationController: self.navigationController)
//        coordinator.delegate = self
//        coordinator.start()
//        self.childCoordinators.append(coordinator)
//    }
//
//    private func showDetailViewController(_ tag: Int) {
//        let coordinator = DefaultDetailCoordinator(navigationController: navigationController)
//        coordinator.start(tag)
//        self.childCoordinators.append(coordinator)
//    }
//}
//
//extension AppCoordinator: MainCoordinatorDelegate {
//    public func pushToDetailVC(_ coordinator: MainFeature.MainCoordinator, _ tag: Int) {
//        self.childCoordinators = self.childCoordinators.filter { $0 !== coordinator }
//        self.showDetailViewController(tag)
//    }
//}

