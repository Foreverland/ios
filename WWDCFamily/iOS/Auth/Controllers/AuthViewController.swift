import UIKit

protocol AuthViewControllerDelegate: class {
    func authViewController(_ authViewControllerDidLogIn: AuthViewController)
}

class AuthViewController: UIViewController {
    weak var delegate: AuthViewControllerDelegate?

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
}

extension AuthViewController: AuthViewDelegate {
    func authView(_ authViewDidPressLogIn: AuthView) {
        self.delegate?.authViewController(self)
    }
}
