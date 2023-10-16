import UIKit
import RyuHeeJaeAssignmentKit
import RyuHeeJaeAssignmentUI

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil
    ) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        let viewController = UIViewController()
        viewController.view.backgroundColor = .white
        window?.rootViewController = viewController
        window?.makeKeyAndVisible()
        
        RyuHeeJaeAssignmentKit.hello()
        RyuHeeJaeAssignmentUI.hello()

        return true
    }

}