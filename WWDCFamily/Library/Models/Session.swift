import Foundation
import Firebase
import FirebaseAuthUI

class Session {

    private enum Defaults: String {
        case sessionToken = "SessionToken"
    }

    typealias AuthCompletion = (Bool) -> Void

    static let sharedInstance = Session()

    init() {
        loadStoredSession()
    }

    // MARK: Auth Properties

    var isLoggedIn: Bool {
        let auth = FIRAuth.auth()

        return auth?.currentUser != nil
    }

    private(set) var sessionToken: String? {
        didSet {
            UserDefaults.standard.set(sessionToken, forKey: Defaults.sessionToken.rawValue)
        }
    }

    // MARK: Defaults

    private func loadStoredSession() {
        sessionToken = UserDefaults.standard.string(forKey: Defaults.sessionToken.rawValue)
    }

    // MARK: Authentication

    func login(completion: AuthCompletion) {
        //STUB: Success
        setAuthProperties()
        completion(true)
    }

    func logout(completion: AuthCompletion) {
        //STUB: Success
        removeAuthProperties()
        completion(true)
    }

    // MARK: Helpers

    // Sets local auth properties after a successful login
    private func setAuthProperties() {
        sessionToken = "dummySessionToken"
    }

    // Removes local auth properies after a successful log out
    private func removeAuthProperties() {
        do {
            let authUI = FUIAuth.defaultAuthUI()
            try authUI?.signOut()
        } catch let error {
            // This error is most likely a network error, so retrying here makes more sense.
            // TODO: Implement retrying.
            fatalError("Could not sign out: \(error)")
        }
        sessionToken = nil
    }
}
