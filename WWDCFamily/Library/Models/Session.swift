import Foundation

struct Session {
    static var isLoggedIn: Bool {
        set {
            UserDefaults.standard.set(newValue, forKey: "isLoggedIn")
        }

        get {
            return UserDefaults.standard.bool(forKey: "isLoggedIn")
        }
    }
}
