import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {

        window = UIWindow(frame: UIScreen.main.bounds)

        if Session.isLoggedIn {
            window?.rootViewController = MapViewController()
        } else {
            let controller = AuthViewController()
            controller.delegate = self
            window?.rootViewController = controller
        }

        window?.makeKeyAndVisible()

        return true
    }
}

extension AppDelegate: AuthViewControllerDelegate {
    func authViewController(_ authViewControllerDidLogIn: AuthViewController) {
        Session.isLoggedIn = true
        window?.rootViewController = MapViewController()
        window?.makeKeyAndVisible()
    }
}
