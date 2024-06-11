import UIKit
import MapKit
import CoreLocation

class MapViewController: UIViewController, CLLocationManagerDelegate {
    private let locationManager = CLLocationManager()

    private lazy var mapView: MKMapView = {
        let map = MKMapView()
        map.setUserTrackingMode(.followWithHeading, animated: true)
        return map
    }()

    private lazy var mapTypeButton: UIButton = {
        let button = UIButton()
        let image = UIImage(systemName: "square.3.stack.3d")?.withTintColor(.white, renderingMode: .alwaysOriginal)
        button.setImage(image, for: .normal)
        button.backgroundColor = .labelBack
        button.layer.cornerRadius = 20
        button.addTarget(self, action: #selector(toggleMapType), for: .touchUpInside)
        return button
    }()

    private lazy var locationButton: UIButton = {
            let button = UIButton()
            let image = UIImage(systemName: "dot.scope")?.withTintColor(.white, renderingMode: .alwaysOriginal)
            button.setImage(image, for: .normal)
            button.backgroundColor = .labelBack
            button.layer.cornerRadius = 20
            button.addTarget(self, action: #selector(centerToUserLocation), for: .touchUpInside)
            return button
        }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .clear
        setupViews()
    }

    private func setupViews() {
        [mapView, mapTypeButton, locationButton].forEach {
            view.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        NSLayoutConstraint.activate([
            mapView.topAnchor.constraint(equalTo: view.topAnchor),
            mapView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            mapView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            mapView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            mapTypeButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -200),
            mapTypeButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            mapTypeButton.widthAnchor.constraint(equalToConstant: 50),
            mapTypeButton.heightAnchor.constraint(equalToConstant: 50),
            locationButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -200),
            locationButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            locationButton.widthAnchor.constraint(equalToConstant: 50),
            locationButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }

    @objc
    private func toggleMapType() {
        if mapView.mapType == .standard {
            mapView.mapType = .hybrid
        } else {
            mapView.mapType = .standard
        }
    }

    @objc
    private func centerToUserLocation() {
    }
}
