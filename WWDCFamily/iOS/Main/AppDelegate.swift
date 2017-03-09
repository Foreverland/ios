import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {

        window = UIWindow(frame: UIScreen.main.bounds)

        if Session.isLoggedIn {
            window?.rootViewController = self.mapViewController()
        } else {
            window?.rootViewController = self.authViewController()
        }

        window?.makeKeyAndVisible()

        return true
    }

    func authViewController() -> AuthViewController {
        let controller = AuthViewController()
        controller.delegate = self

        return controller
    }

    func mapViewController() -> UINavigationController {
        let controller = MapViewController()
        let navigationController = UINavigationController(rootViewController: controller)

        return navigationController
    }
}

extension AppDelegate: AuthViewControllerDelegate {
    func authViewController(_ authViewControllerDidLogIn: AuthViewController) {
        Session.isLoggedIn = true
        window?.rootViewController = self.mapViewController()
        window?.makeKeyAndVisible()
    }
}
