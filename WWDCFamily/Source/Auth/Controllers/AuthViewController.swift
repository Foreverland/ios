import UIKit
import Firebase
import FirebaseAuthUI
import FirebaseTwitterAuthUI

final class AuthViewController: UIViewController, RootChildViewController {
    fileprivate var authStateDidChangeHandle: FIRAuthStateDidChangeListenerHandle?
    fileprivate(set) var auth: FIRAuth? = FIRAuth.auth()
    fileprivate(set) var authUI: FUIAuth? = FUIAuth.defaultAuthUI()

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

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        self.authStateDidChangeHandle = self.auth?.addStateDidChangeListener(self.updateUI(auth:user:))
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if let handle = self.authStateDidChangeHandle {
            self.auth?.removeStateDidChangeListener(handle)
        }
    }

    func updateUI(auth: FIRAuth, user: FIRUser?) {
        if self.auth?.currentUser != nil {
            Session.sharedInstance.login { [weak self] (success) in
                guard success else {
                    // Present failure modal
                    return
                }

                self?.router.routeToMap(animated: true)
            }
        } else {
            print("Not signed in")
        }
    }
}

extension AuthViewController: AuthViewDelegate {
    func authView(_ authViewDidPressLogIn: AuthView) {
        self.authUI?.providers = [FUITwitterAuth()]
        self.authUI?.isSignInWithEmailHidden = true

        let controller = self.authUI!.authViewController()
        controller.navigationBar.isHidden = false
        self.present(controller, animated: true, completion: nil)
    }
}
