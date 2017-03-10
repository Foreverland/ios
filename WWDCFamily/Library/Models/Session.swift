import Foundation
import Firebase

struct Session {
    static let unauthorizedNotificationName = NSNotification.Name(rawValue: "unauthorizedNotificationName")

    static var isLoggedIn: Bool {
        get {
            let auth = FIRAuth.auth()

            return auth?.currentUser != nil
        }
    }
}
