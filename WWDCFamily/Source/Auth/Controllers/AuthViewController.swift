import UIKit

final class AuthViewController: UIViewController, RootChildViewController {

    @IBOutlet private weak var headlineLabel: UILabel! {
        didSet {
            headlineLabel.text = "Auth.Title".localized
        }
    }
    @IBOutlet private weak var authButton: UIButton! {
        didSet {
            authButton.setTitle("Auth.Login".localized.uppercased(), for: .normal)
        }
    }

    override func loadView() {
        let view = UIView.instanceFromNib() as AuthView
        view.delegate = self
        self.view = view
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.isNavigationBarHidden = true
    }

    // MARK: UIStatusBar

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
}

extension AuthViewController: AuthViewDelegate {
    func authView(_ authViewDidPressLogIn: AuthView) {
        Session.sharedInstance.login { [weak self] (success) in
            guard success else {
                // Present failure modal
                return
            }

            self?.rootNavigationController.routeToMap(animated: true)
        }
    }
}
