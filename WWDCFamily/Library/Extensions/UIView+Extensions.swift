import UIKit

extension UIView {
    class func instanceFromNib<T: UIView>(bundle: Bundle = .main) -> T {
        return UINib(nibName: String(describing: T.self), bundle: bundle).instantiate(withOwner: nil, options: nil)[0] as! T
    }
}
