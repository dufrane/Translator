//
//  MenuView.swift
//  testProject
//
//  Created by Dmytro Vasylenko on 11.02.2025.
//

import UIKit

protocol BottomNavigationViewDelegate: AnyObject {
    func didTapTranslator()
    func didTapSettings()
}

class BottomNavigationView: UIView {

    weak var delegate: BottomNavigationViewDelegate?

    private let translatorView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private let settingsView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private let translatorImageView: UIImageView = {
        let imageView = UIImageView(image: AssetImages.chat.image)
        imageView.tintColor = .specialText
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    private let settingsImageView: UIImageView = {
        let imageView = UIImageView(image: AssetImages.settings.image)
        imageView.tintColor = .specialText
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    private let translatorLabel: UILabel = {
        let label = UILabel()
        label.text = "Translator"
        label.textColor = .specialText
        label.font = .konchmerNormal12()
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let settingsLabel: UILabel = {
        let label = UILabel()
        label.text = "Clicker"
        label.textColor = .specialText
        label.font = .konchmerNormal12()
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setConstraints()
        setupGestures()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupView() {
        backgroundColor = .white
        layer.cornerRadius = 16
        addSubview(translatorView)
        addSubview(settingsView)

        translatorView.addSubview(translatorImageView)
        translatorView.addSubview(translatorLabel)

        settingsView.addSubview(settingsImageView)
        settingsView.addSubview(settingsLabel)
    }

    private func setupGestures() {
        let translatorTap = UITapGestureRecognizer(target: self, action: #selector(didTapTranslator))
        translatorView.addGestureRecognizer(translatorTap)

        let settingsTap = UITapGestureRecognizer(target: self, action: #selector(didTapSettings))
        settingsView.addGestureRecognizer(settingsTap)
    }

    @objc private func didTapTranslator() {
        delegate?.didTapTranslator()
    }

    @objc private func didTapSettings() {
        delegate?.didTapSettings()
    }
}

extension BottomNavigationView {
    private func setConstraints() {
        NSLayoutConstraint.activate([
            translatorView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0),
            translatorView.topAnchor.constraint(equalTo: topAnchor, constant: 0),
            translatorView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0),
            translatorView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.5)
            ])
        
        NSLayoutConstraint.activate([
            settingsView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0),
            settingsView.topAnchor.constraint(equalTo: topAnchor, constant: 0),
            settingsView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0),
            settingsView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.5)
            ])
            
        NSLayoutConstraint.activate([
            translatorImageView.leadingAnchor.constraint(equalTo: translatorView.leadingAnchor, constant: 43.5),
            translatorImageView.topAnchor.constraint(equalTo: translatorView.topAnchor, constant: 19),
            translatorImageView.widthAnchor.constraint(equalToConstant: 24),
            translatorImageView.heightAnchor.constraint(equalToConstant: 24)
            ])
        
        NSLayoutConstraint.activate([
            translatorLabel.leadingAnchor.constraint(equalTo: translatorView.leadingAnchor, constant: 24),
            translatorLabel.bottomAnchor.constraint(equalTo: translatorView.bottomAnchor, constant: -19),
            ])
        
        NSLayoutConstraint.activate([
            settingsImageView.trailingAnchor.constraint(equalTo: settingsView.trailingAnchor, constant: -43.5),
            settingsImageView.topAnchor.constraint(equalTo: settingsView.topAnchor, constant: 19),
            settingsImageView.widthAnchor.constraint(equalToConstant: 24),
            settingsImageView.heightAnchor.constraint(equalToConstant: 24),
            ])
        NSLayoutConstraint.activate([
            settingsLabel.centerXAnchor.constraint(equalTo: settingsView.centerXAnchor),
            settingsLabel.bottomAnchor.constraint(equalTo: settingsView.bottomAnchor, constant: -19)
        ])
    }
}
