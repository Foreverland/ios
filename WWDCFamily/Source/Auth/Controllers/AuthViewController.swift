import UIKit
import Firebase
import FirebaseAuthUI
import FirebaseTwitterAuthUI

protocol AuthViewControllerDelegate: class {
    func authViewControllerDidLogIn(_ authViewController: AuthViewController)
}

class AuthViewController: UIViewController {
    weak var delegate: AuthViewControllerDelegate?

    fileprivate var authStateDidChangeHandle: FIRAuthStateDidChangeListenerHandle?
    fileprivate(set) var auth: FIRAuth? = FIRAuth.auth()
    fileprivate(set) var authUI: FUIAuth? = FUIAuth.defaultAuthUI()

    init() {
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func loadView() {
        let view = UIView.instanceFromNib() as AuthView
        view.delegate = self

        self.view = view
    }

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
            self.delegate?.authViewControllerDidLogIn(self)
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
