import UIKit

final class CompassViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.isNavigationBarHidden = false
        view.backgroundColor = .labelBack
        navigationItem.title = "Compass"
    }
}
