//
//  ResultViewController.swift
//  testProject
//
//  Created by Dmytro Vasylenko on 12.02.2025.
//

import UIKit

protocol ResultViewProtocol: AnyObject {
    func showFact(_ fact: String)
}

final class ResultViewController: UIViewController, ResultViewProtocol {

    private let petImage: UIImage

    var presenter: ResultPresenterProtocol?

    // MARK: - UI Elements
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Result"
        label.font = .konchmerNormal32()
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let closeButton: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 24
        view.translatesAutoresizingMaskIntoConstraints = false

        let closeImage = UIImageView(image: AssetImages.close.image)
        closeImage.tintColor = .specialText
        closeImage.translatesAutoresizingMaskIntoConstraints = false

        view.addSubview(closeImage)
        NSLayoutConstraint.activate([
            closeImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            closeImage.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            closeImage.widthAnchor.constraint(equalToConstant: 28),
            closeImage.heightAnchor.constraint(equalToConstant: 28)
        ])

        return view
    }()

    private let speechBubbleView: UIView = {
        let view = UIView()
        view.backgroundColor = .specialBlue
        view.layer.cornerRadius = 16
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private let speechLabel: UILabel = {
        let label = UILabel()
        label.font = .konchmerNormal12()
        label.textAlignment = .center
        label.numberOfLines = 0
        label.text = "Loading..."
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let petImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    // MARK: - Init
    init(petImage: UIImage) {
        self.petImage = petImage
        super.init(nibName: nil, bundle: nil)
        self.presenter = ResultPresenter(view: self)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupSubviews()
        setConstraints()
        presenter?.fetchFact()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: false)
    }

    private func setupSubviews() {
        view.backgroundColor = .specialBackground

        closeButton.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(closeTapped)))

        view.addSubview(titleLabel)
        view.addSubview(closeButton)
        view.addSubview(speechBubbleView)
        view.addSubview(petImageView)

        speechBubbleView.addSubview(speechLabel)
        speechBubbleView.addShaddowOnView()
        petImageView.image = petImage
    }

    // MARK: - Constraints
    private func setConstraints() {
        NSLayoutConstraint.activate([
            closeButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            closeButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 5),
            closeButton.widthAnchor.constraint(equalToConstant: 48),
            closeButton.heightAnchor.constraint(equalToConstant: 48)
        ])

        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 12),
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            titleLabel.widthAnchor.constraint(equalToConstant: 350)
        ])

        NSLayoutConstraint.activate([
            speechBubbleView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 91),
            speechBubbleView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            speechBubbleView.widthAnchor.constraint(equalToConstant: 291),
            speechBubbleView.heightAnchor.constraint(equalToConstant: 142)
        ])

        NSLayoutConstraint.activate([
            speechLabel.centerXAnchor.constraint(equalTo: speechBubbleView.centerXAnchor),
            speechLabel.centerYAnchor.constraint(equalTo: speechBubbleView.centerYAnchor),
            speechLabel.leadingAnchor.constraint(equalTo: speechBubbleView.leadingAnchor, constant: 16),
            speechLabel.trailingAnchor.constraint(equalTo: speechBubbleView.trailingAnchor, constant: -16)
        ])

        NSLayoutConstraint.activate([
            petImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            petImageView.topAnchor.constraint(equalTo: speechBubbleView.bottomAnchor, constant: 125),
            petImageView.widthAnchor.constraint(equalToConstant: 184),
            petImageView.heightAnchor.constraint(equalToConstant: 184)
        ])
    }

    @objc private func closeTapped() {
        navigationController?.popViewController(animated: true)
    }

    // MARK: - ResultViewProtocol
    func showFact(_ fact: String) {
        speechLabel.text = fact
    }
}
