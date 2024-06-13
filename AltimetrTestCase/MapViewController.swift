import UIKit
import MapKit
import CoreLocation

class MapViewController: UIViewController {
    private let locationManager = CLLocationManager()
    private var isLocationUpdating = true

    private lazy var mapView: MKMapView = {
        let map = MKMapView()
        map.setUserTrackingMode(.followWithHeading, animated: true)
        map.showsCompass = false
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
        let longPressRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(handleLongPress(_:)))
        button.addGestureRecognizer(longPressRecognizer)
        return button
    }()

    private lazy var compassButton: UIButton = {
        let button = UIButton()
        let image = UIImage(systemName: "safari")?.withTintColor(.white, renderingMode: .alwaysOriginal)
        button.setImage(image, for: .normal)
        button.backgroundColor = .labelBack
        button.layer.cornerRadius = 20
        button.addTarget(self, action: #selector(showCompassViewController), for: .touchUpInside)
        return button
    }()

    private lazy var gpsIndicatorView: GPSIndicatorView = {
        let view = GPSIndicatorView()
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .clear
        navigationController?.isNavigationBarHidden = true
        setupViews()
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }

    private func updateLocationButtonAppearance() {
        locationButton.backgroundColor = isLocationUpdating ? .labelBack : .black
    }

    @objc
    private func toggleMapType() {
        mapView.mapType = mapView.mapType == .standard ? .hybrid : .standard
    }

    @objc
    private func centerToUserLocation() {
        guard let userLocation = locationManager.location?.coordinate else { return }
        let region = MKCoordinateRegion(center: userLocation, latitudinalMeters: 1000, longitudinalMeters: 1000)
        mapView.setRegion(region, animated: true)
    }

    @objc
    private func handleLongPress(_ gestureRecognizer: UILongPressGestureRecognizer) {
        guard gestureRecognizer.state == .began else { return }
        isLocationUpdating.toggle()
        updateLocationButtonAppearance()
        if isLocationUpdating {
            locationManager.startUpdatingLocation()
        } else {
            locationManager.stopUpdatingLocation()
        }
    }

    @objc
    private func showCompassViewController() {
        let compassViewController = CompassViewController()
        navigationController?.pushViewController(compassViewController, animated: true)
    }
}

extension MapViewController {
    private func setupViews() {
        [mapView, compassButton, gpsIndicatorView, mapTypeButton, locationButton].forEach {
            view.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        NSLayoutConstraint.activate([
            mapView.topAnchor.constraint(equalTo: view.topAnchor),
            mapView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            mapView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            mapView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            compassButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 70),
            compassButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            compassButton.widthAnchor.constraint(equalToConstant: 50),
            compassButton.heightAnchor.constraint(equalToConstant: 50),
            gpsIndicatorView.topAnchor.constraint(equalTo: compassButton.topAnchor),
            gpsIndicatorView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            gpsIndicatorView.widthAnchor.constraint(equalToConstant: 60),
            gpsIndicatorView.heightAnchor.constraint(equalToConstant: 30),
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
}

extension MapViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        showGPSSignal(locations)
    }

    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        switch manager.authorizationStatus {
        case .notDetermined:
            print("Location access not determined.")
        case .restricted, .denied:
            print("Location access restricted or denied.")
        case .authorizedWhenInUse, .authorizedAlways:
            locationManager.startUpdatingLocation()
            isLocationUpdating = true
            print("Location updates started.")
        @unknown default:
            fatalError("Unknown authorization status.")
        }
    }

    private func showGPSSignal(_ locations: [CLLocation]) {
        guard let location = locations.last else { return }
        let quality = calculateGPSQuality(from: location.horizontalAccuracy)
        gpsIndicatorView.updateGPSLevel(quality)
    }

    private func calculateGPSQuality(from accuracy: CLLocationAccuracy) -> GPSLevel {
        let quality = (100 - accuracy) / 100
        switch quality {
        case 0.9...:
            return .high
        case 0.6..<0.9:
            return .medium
        case 0.3..<0.6:
            return .low
        default:
            return .none
        }
    }
}
