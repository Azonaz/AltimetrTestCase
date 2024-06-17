import UIKit

final class DataView: UIView {
    private lazy var leftSquareView: UIView = {
        let view = UIView()
        view.backgroundColor = .blueUniversal
        view.layer.cornerRadius = 30
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    let rightSquareView: UIView = {
        let view = UIView()
        view.backgroundColor = .green
        view.layer.cornerRadius = 16
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    let leftLabel: UILabel = {
        let label = UILabel()
        label.text = "Left Label"
        label.textAlignment = .center
        label.textColor = .white
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    let rightLabel: UILabel = {
        let label = UILabel()
        label.text = "Right Label"
        label.textAlignment = .center
        label.textColor = .white
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var middleLabel1: UILabel = {
            let label = UILabel()
            label.text = "Middle Label 1"
            label.textAlignment = .center
            label.textColor = .blueUniversal
            label.translatesAutoresizingMaskIntoConstraints = false
            return label
        }()

        private lazy var middleLabel2: UILabel = {
            let label = UILabel()
            label.text = "Middle Label 2"
            label.textAlignment = .center
            label.textColor = .white
            label.translatesAutoresizingMaskIntoConstraints = false
            return label
        }()

        private lazy var middleLabel3: UILabel = {
            let label = UILabel()
            label.text = "Middle Label 3"
            label.textAlignment = .center
            label.textColor = .blueUniversal
            label.translatesAutoresizingMaskIntoConstraints = false
            return label
        }()

        private lazy var middleLabel4: UILabel = {
            let label = UILabel()
            label.text = "Middle Label 4"
            label.textAlignment = .center
            label.textColor = .white
            label.translatesAutoresizingMaskIntoConstraints = false
            return label
        }()

    override init(frame: CGRect) {
        super.init(frame: frame)
                backgroundColor = .labelBack
                layer.cornerRadius = 35
        addSubview(leftSquareView)
                addSubview(rightSquareView)
                leftSquareView.addSubview(leftLabel)
                rightSquareView.addSubview(rightLabel)
                addSubview(middleLabel1)
                addSubview(middleLabel2)
                addSubview(middleLabel3)
                addSubview(middleLabel4)
                setupConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupConstraints() {
            NSLayoutConstraint.activate([
                leftSquareView.widthAnchor.constraint(equalToConstant: 110),
                leftSquareView.heightAnchor.constraint(equalToConstant: 110),
                leftSquareView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12),
                leftSquareView.centerYAnchor.constraint(equalTo: centerYAnchor),
                rightSquareView.widthAnchor.constraint(equalToConstant: 70),
                rightSquareView.heightAnchor.constraint(equalToConstant: 70),
                rightSquareView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12),
                rightSquareView.centerYAnchor.constraint(equalTo: centerYAnchor),

                leftLabel.leadingAnchor.constraint(equalTo: leftSquareView.leadingAnchor, constant: 8),
                leftLabel.trailingAnchor.constraint(equalTo: leftSquareView.trailingAnchor, constant: -8),
                leftLabel.topAnchor.constraint(equalTo: leftSquareView.topAnchor, constant: 8),
                leftLabel.bottomAnchor.constraint(equalTo: leftSquareView.bottomAnchor, constant: -8),

                rightLabel.leadingAnchor.constraint(equalTo: rightSquareView.leadingAnchor, constant: 8),
                rightLabel.trailingAnchor.constraint(equalTo: rightSquareView.trailingAnchor, constant: -8),
                rightLabel.topAnchor.constraint(equalTo: rightSquareView.topAnchor, constant: 8),
                rightLabel.bottomAnchor.constraint(equalTo: rightSquareView.bottomAnchor, constant: -8),

                middleLabel1.leadingAnchor.constraint(equalTo: leftLabel.trailingAnchor, constant: 16),
                middleLabel1.topAnchor.constraint(equalTo: topAnchor, constant: 8),

                middleLabel2.leadingAnchor.constraint(equalTo: middleLabel1.leadingAnchor),
                middleLabel2.topAnchor.constraint(equalTo: middleLabel1.bottomAnchor, constant: 8),

                middleLabel3.leadingAnchor.constraint(equalTo: middleLabel1.leadingAnchor),
                middleLabel3.topAnchor.constraint(equalTo: middleLabel2.bottomAnchor, constant: 8),

                middleLabel4.leadingAnchor.constraint(equalTo: middleLabel1.leadingAnchor),
                middleLabel4.topAnchor.constraint(equalTo: middleLabel3.bottomAnchor, constant: 8)
            ])
        }
}
