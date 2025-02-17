//
//  SettingsViewController.swift
//  testProject
//
//  Created by Dmytro Vasylenko on 11.02.2025.
//

import UIKit

class SettingsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, BottomNavigationViewDelegate {

    private let settingsOptions = ["Rate Us", "Share App", "Contact Us", "Restore Purchases", "Privacy Policy", "Terms of Use"]

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Settings"
        label.textAlignment = .center
        label.font = .konchmerNormal32()
        label.textColor = .specialText
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let bottomNavigationView = BottomNavigationView()

    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .specialBackground
        tableView.separatorStyle = .none
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .specialBackground
        bottomNavigationView.delegate = self

        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(SettingsCell.self, forCellReuseIdentifier: "SettingsCell")

        setupSubviews()
        setConstraints()
    }
    
    private func setupSubviews() {
        view.addSubview(titleLabel)
        view.addSubview(tableView)
        view.addSubview(bottomNavigationView)
        
        bottomNavigationView.addShaddowOnView()
        bottomNavigationView.translatesAutoresizingMaskIntoConstraints = false
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    func didTapTranslator() {
        navigationController?.popToRootViewController(animated: true)
    }

    func didTapSettings() {
        print("Вже в Settings, нічого не робимо")
    }
}

// MARK: - UITableViewDataSource, UITableViewDelegate
// MARK: - UITableViewDataSource, UITableViewDelegate
extension SettingsViewController {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return settingsOptions.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "SettingsCell", for: indexPath) as? SettingsCell else {
            return UITableViewCell()
        }
        cell.configure(with: settingsOptions[indexPath.row])
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 64
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)

        let selectedOption = settingsOptions[indexPath.row]
        let detailVC = DetailViewController(optionTitle: selectedOption)
        navigationController?.pushViewController(detailVC, animated: true)
    }
}



// MARK: - Layout Constraints
extension SettingsViewController {
    private func setConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 12),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            titleLabel.heightAnchor.constraint(equalToConstant: 58)
        ])
        
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 12),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -150)
        ])

        NSLayoutConstraint.activate([
            bottomNavigationView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 87),
            bottomNavigationView.widthAnchor.constraint(equalToConstant: 216),
            bottomNavigationView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16),
            bottomNavigationView.heightAnchor.constraint(equalToConstant: 82)
        ])
    }
}


