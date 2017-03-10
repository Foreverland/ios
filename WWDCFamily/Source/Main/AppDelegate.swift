import UIKit
import Firebase
import FirebaseAuthUI
import Fabric
import TwitterKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        FIRApp.configure()
        Fabric.with([Twitter.self])

        NotificationCenter.default.addObserver(self, selector: #selector(AppDelegate.logOut), name: Session.unauthorizedNotificationName, object: nil)

        window = UIWindow(frame: UIScreen.main.bounds)

        if Session.isLoggedIn {
            window?.rootViewController = self.mapViewController()
        } else {
            window?.rootViewController = self.authViewController()
        }

        window?.makeKeyAndVisible()

        return true
    }

    func logOut() {
        window?.rootViewController = self.authViewController()
        window?.makeKeyAndVisible()
    }

    func authViewController() -> UINavigationController {
        let controller = AuthViewController()
        controller.delegate = self
        let navigationController = UINavigationController(rootViewController: controller)
        navigationController.isNavigationBarHidden = true

        return navigationController
    }

    func mapViewController() -> UINavigationController {
        let controller = MapViewController()
        let navigationController = UINavigationController(rootViewController: controller)

        return navigationController
    }

    func application(_ app: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey : Any]) -> Bool {
        let sourceApplication = options[UIApplicationOpenURLOptionsKey.sourceApplication] as! String?
        return self.handleOpenUrl(url, sourceApplication: sourceApplication)
    }

    func application(_ application: UIApplication, open url: URL, sourceApplication: String?, annotation: Any) -> Bool {
        return self.handleOpenUrl(url, sourceApplication: sourceApplication)
    }

    func handleOpenUrl(_ url: URL, sourceApplication: String?) -> Bool {
        return FUIAuth.defaultAuthUI()?.handleOpen(url, sourceApplication: sourceApplication) ?? false
    }
}

extension AppDelegate: AuthViewControllerDelegate {
    func authViewControllerDidLogIn(_ authViewController: AuthViewController) {
        window?.rootViewController = self.mapViewController()
        window?.makeKeyAndVisible()
    }
}
