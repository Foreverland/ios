import UIKit

protocol RootChildViewController: class {

}

extension RootChildViewController where Self : UIViewController {
    var rootNavigationController: RootNavigationController! {
        return navigationController as! RootNavigationController
    }
}

final class RootNavigationController: UINavigationController {

    // MARK: Child VCs

    private lazy var authVC: AuthViewController = {
        return AuthViewController()
    }()

    private lazy var mapVC: MapViewController = {
        return MapViewController()
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        initialRouting()
    }

    // MARK: Routing

    func routeToMap(animated: Bool) {
        setViewControllers([authVC, mapVC], animated: animated)
    }

    func routeToAuth(animated: Bool) {
        popToRootViewController(animated: animated)
    }

    private func initialRouting() {
        setViewControllers([authVC, mapVC], animated: false)

        guard Session.sharedInstance.isLoggedIn else {
            routeToAuth(animated: false)
            return
        }

        routeToMap(animated: false)
    }

}
