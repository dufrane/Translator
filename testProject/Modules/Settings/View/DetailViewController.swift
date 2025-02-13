//
//  DetailViewController.swift
//  testProject
//
//  Created by Dmytro Vasylenko on 12.02.2025.
//

import UIKit

class DetailViewController: UIViewController {
    
    private let optionTitle: String

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .konchmerNormal32()
        label.textColor = .specialText
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    init(optionTitle: String) {
        self.optionTitle = optionTitle
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .specialBackground
        titleLabel.text = optionTitle
        setupSubviews()
        setupBackButton()
        setConstraints()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: false)
    }

    private func setupSubviews() {
        view.addSubview(titleLabel)
    }

    private func setupBackButton() {
        let backButton = UIBarButtonItem(image: UIImage(systemName: "chevron.left"),
                                         style: .plain,
                                         target: self,
                                         action: #selector(backTapped))
        backButton.tintColor = .specialText
        navigationItem.leftBarButtonItem = backButton
    }

    @objc private func backTapped() {
        navigationController?.popViewController(animated: true)
    }

    private func setConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            titleLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
}

