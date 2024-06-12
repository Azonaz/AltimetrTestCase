import UIKit

enum GPSLevel {
    case none
    case low
    case medium
    case high
}

class GPSIndicatorView: UIView {

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
        label.font = UIFont.systemFont(ofSize: 15, weight: .bold)
        addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 4),
            label.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])

        let stick = UIView()
        stick.backgroundColor = .white
        addSubview(stick)
        stick.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stick.widthAnchor.constraint(equalToConstant: 3),
            stick.heightAnchor.constraint(equalToConstant: 5),
            stick.leadingAnchor.constraint(equalTo: label.trailingAnchor, constant: 5),
            stick.bottomAnchor.constraint(equalTo: label.bottomAnchor)
        ])

        let stick2 = UIView()
        stick2.backgroundColor = .white
        addSubview(stick2)
        stick2.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stick2.widthAnchor.constraint(equalToConstant: 3),
            stick2.heightAnchor.constraint(equalToConstant: 10),
            stick2.leadingAnchor.constraint(equalTo: stick.trailingAnchor, constant: 3),
            stick2.bottomAnchor.constraint(equalTo: label.bottomAnchor)
        ])

        let stick3 = UIView()
        stick3.backgroundColor = .white
        addSubview(stick3)
        stick3.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stick3.widthAnchor.constraint(equalToConstant: 3),
            stick3.heightAnchor.constraint(equalToConstant: 15),
            stick3.leadingAnchor.constraint(equalTo: stick2.trailingAnchor, constant: 3),
            stick3.bottomAnchor.constraint(equalTo: label.bottomAnchor)
        ])
    }
}
