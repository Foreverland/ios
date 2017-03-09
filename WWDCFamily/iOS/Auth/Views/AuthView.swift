import UIKit

protocol AuthViewDelegate: class {
    func authView(_ authViewDidPressLogIn: AuthView)
}

class AuthView: UIView {
    weak var delegate: AuthViewDelegate?

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    @IBAction func logIn(_ sender: UIButton) {
        self.delegate?.authView(self)
    }
}
