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
        return configureButton(imageName: "square.3.stack.3d", action: #selector(toggleMapType))
    }()

    private lazy var locationButton: UIButton = {
        let button = configureButton(imageName: "dot.scope", action: #selector(centerToUserLocation))
        let longPressRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(handleLongPress(_:)))
        button.addGestureRecognizer(longPressRecognizer)
        return button
    }()

    private lazy var compassButton: UIButton = {
        return configureButton(imageName: "safari", action: #selector(showCompassViewController))
    }()

    private lazy var gpsIndicatorView: GPSIndicatorView = {
        let view = GPSIndicatorView()
        return view
    }()

    private lazy var shareButton: UIButton = {
        return configureButton(imageName: "square.and.arrow.up", action: #selector(showShareViewController))
    }()

    private lazy var settingsButton: UIButton = {
        return configureButton(imageName: "equal", action: #selector(showSettingsViewController))
    }()

    private lazy var appButton: UIButton = {
        let button = UIButton()
        let image = UIImage(named: "launchLogo")?.withRenderingMode(.alwaysOriginal)
            .resize(targetSize: CGSize(width: 30, height: 30))
        button.setImage(image, for: .normal)
        button.backgroundColor = .labelBack
        button.layer.cornerRadius = 16
        button.contentMode = .center
        button.addTarget(self, action: #selector(didTapAppButton), for: .touchUpInside)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
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

    @objc
    private func showShareViewController() {
        let shareViewController = ShareViewController()
        navigationController?.pushViewController(shareViewController, animated: true)
    }

    @objc
    private func showSettingsViewController() {
        let settingsViewController = SettingsViewController()
        navigationController?.pushViewController(settingsViewController, animated: true)
    }

    @objc
    private func didTapAppButton() {
    }
}

extension MapViewController {
    private func setupViews() {
        view.backgroundColor = .clear
        navigationController?.navigationBar.tintColor = .white
        navigationController?.navigationBar.titleTextAttributes = [
            .foregroundColor: UIColor.white
        ]
        navigationController?.isNavigationBarHidden = true
        [mapView, compassButton, gpsIndicatorView, mapTypeButton, locationButton,
         shareButton, settingsButton, appButton].forEach {
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
            gpsIndicatorView.topAnchor.constraint(equalTo: compassButton.topAnchor),
            gpsIndicatorView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            gpsIndicatorView.widthAnchor.constraint(equalToConstant: 60),
            gpsIndicatorView.heightAnchor.constraint(equalToConstant: 30),
            mapTypeButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -200),
            mapTypeButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            locationButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -200),
            locationButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            shareButton.bottomAnchor.constraint(equalTo: mapTypeButton.topAnchor, constant: -40),
            shareButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            settingsButton.bottomAnchor.constraint(equalTo: locationButton.topAnchor, constant: -40),
            settingsButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            appButton.topAnchor.constraint(equalTo: gpsIndicatorView.bottomAnchor, constant: 40),
            appButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20)
        ])
        [compassButton, mapTypeButton, locationButton, shareButton, settingsButton, appButton].setButtonSizes(50)
    }

    private func configureButton(imageName: String, action: Selector) -> UIButton {
        let button = UIButton()
        let image = UIImage(systemName: imageName)?.withTintColor(.white, renderingMode: .alwaysOriginal)
        button.setImage(image, for: .normal)
        button.backgroundColor = .labelBack
        button.layer.cornerRadius = 16
        button.addTarget(self, action: action, for: .touchUpInside)
        return button
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
