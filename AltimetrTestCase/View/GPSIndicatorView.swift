import UIKit

enum GPSLevel {
    case none
    case low
    case medium
    case high
}

class GPSIndicatorView: UIView {
    private var sticks: [UIView] = []

    init() {
        super.init(frame: .zero)
        setupViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupViews() {
        backgroundColor = UIColor.labelBack
        layer.cornerRadius = 5

        let label = UILabel()
        label.text = "GPS"
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 4),
            label.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])

        let stick3 = createStick(height: 13)
        let stick2 = createStick(height: 9)
        let stick1 = createStick(height: 5)
        sticks = [stick1, stick2, stick3]

        NSLayoutConstraint.activate([
            stick3.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -4),
            stick3.centerYAnchor.constraint(equalTo: centerYAnchor),
            stick2.trailingAnchor.constraint(equalTo: stick3.leadingAnchor, constant: -3),
            stick2.bottomAnchor.constraint(equalTo: stick3.bottomAnchor),
            stick1.trailingAnchor.constraint(equalTo: stick2.leadingAnchor, constant: -3),
            stick1.bottomAnchor.constraint(equalTo: stick3.bottomAnchor)
        ])
    }

    private func createStick(height: CGFloat) -> UIView {
        let stick = UIView()
        stick.backgroundColor = .white
        addSubview(stick)
        stick.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stick.widthAnchor.constraint(equalToConstant: 3),
            stick.heightAnchor.constraint(equalToConstant: height)
        ])
        return stick
    }

    func updateGPSLevel(_ level: GPSLevel) {
        for (index, stick) in sticks.enumerated() {
            switch level {
            case .none:
                stick.backgroundColor = .white
            case .low:
                stick.backgroundColor = index == 0 ? .orange : .white
            case .medium:
                stick.backgroundColor = index <= 1 ? .orange : .white
            case .high:
                stick.backgroundColor = .orange
            }
        }
    }
}
