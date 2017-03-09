import UIKit

extension UIView {
    class func instanceFromNib<T: UIView>(nibName: String, bundle: Bundle = .main) -> T {
        return UINib(nibName: nibName, bundle: bundle).instantiate(withOwner: nil, options: nil)[0] as! T
    }
}
