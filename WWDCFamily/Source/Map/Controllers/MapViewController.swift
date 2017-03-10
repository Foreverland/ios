import UIKit
import FirebaseAuthUI

class MapViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Sign out", style: .done, target: self, action: #selector(signOut))
        view.backgroundColor = .white
    }

    func signOut() {
        do {
            let authUI = FUIAuth.defaultAuthUI()
            try authUI?.signOut()
            NotificationCenter.default.post(name: Session.unauthorizedNotificationName, object: nil)
        } catch let error {
            // This error is most likely a network error, so retrying here makes more sense.
            // TODO: Implement retrying.
            fatalError("Could not sign out: \(error)")
        }
    }
}

