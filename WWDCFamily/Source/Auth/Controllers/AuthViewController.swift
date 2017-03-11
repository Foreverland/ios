import UIKit

final class AuthViewController: UIViewController, StoryboardInstance, RootChildViewController {

    static var storyboardName: String = "Core"

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

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.isNavigationBarHidden = true
    }

    // MARK: UI Events

    @IBAction private func didTapLoginButton() {
        Session.sharedInstance.login { [weak self] (success) in
            guard success else {
                // Present failure modal
                return
            }

            self?.rootNavigationController.routeToMap(animated: true)
        }
    }

    // MARK: UIStatusBar

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
}
