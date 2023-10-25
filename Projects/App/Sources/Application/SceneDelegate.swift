//
//  SceneDelegate.swift
//  ProjectDescriptionHelpers
//
//  Created by 류희재 on 2023/10/19.
//

import UIKit

import Domain
import MainFeature
import DetailFeature

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
            
            // 1.
            guard let windowScene = (scene as? UIWindowScene) else { return }
        // 2.
            self.window = UIWindow(windowScene: windowScene)
        // 3.
            let navigationController = UINavigationController(
                rootViewController: MainViewController(
                viewModel: MainViewModel(
                    mainUseCase: DefaultMainUseCase()
                    )
                )
            )
            self.window?.rootViewController = navigationController
        // 4.
            self.window?.makeKeyAndVisible()
        }
    
    
    func sceneDidDisconnect(_ scene: UIScene) {}
    
    func sceneDidBecomeActive(_ scene: UIScene) {}
    
    func sceneWillResignActive(_ scene: UIScene) {}
    
    func sceneWillEnterForeground(_ scene: UIScene) {}
    
    func sceneDidEnterBackground(_ scene: UIScene) {}
}
