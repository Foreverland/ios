import Foundation

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
        return sessionToken != nil
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
        sessionToken = nil
    }
}
