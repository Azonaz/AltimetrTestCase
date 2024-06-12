import UIKit

final class CompassViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.isNavigationBarHidden = false
        view.backgroundColor = .white
        navigationItem.title = "Compass"
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor:
                                                                    UIColor.white]
    }
}
