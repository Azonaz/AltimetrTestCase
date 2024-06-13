import UIKit

extension Array where Element: UIButton {
    func setButtonSizes(_ size: CGFloat) {
        forEach { $0.setButtonSize(size) }
    }
}
