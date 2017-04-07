import UIKit

protocol Routable: class {}

extension Routable where Self : UIViewController {
    var router: Router! {
        return navigationController as! Router
    }
}

final class Router: UINavigationController {
    private lazy var authViewController: AuthViewController = {
        return AuthViewController()
    }()

    private lazy var mapViewController: MapViewController = {
        return MapViewController()
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        initialRouting()
    }

    func routeToMap(animated: Bool) {
        setViewControllers([authViewController, mapViewController], animated: animated)
    }

    func routeToAuth(animated: Bool) {
        isNavigationBarHidden = true
        popToRootViewController(animated: animated)
    }

    private func initialRouting() {
        setViewControllers([authViewController, mapViewController], animated: false)

        guard Session.sharedInstance.isLoggedIn else {
            routeToAuth(animated: false)

            return
        }

        routeToMap(animated: false)
    }
}
