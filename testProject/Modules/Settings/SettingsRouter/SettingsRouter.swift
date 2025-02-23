//
//  SettingsRouter.swift
//  testProject
//
//  Created by Dmytro Vasylenko on 22.02.2025.
//

import UIKit

protocol SettingsRouterProtocol {
    func navigateToDetailScreen(with title: String)
}

final class SettingsRouter: SettingsRouterProtocol {
    private weak var navigationController: UINavigationController?

    init(navigationController: UINavigationController?) {
        self.navigationController = navigationController
    }

    func start() {
        let settingsVC = SettingsViewController()
        let presenter = SettingsPresenter(view: settingsVC, router: self)
        settingsVC.presenter = presenter
        navigationController?.pushViewController(settingsVC, animated: true)
    }

    func navigateToDetailScreen(with title: String) {
        let detailVC = DetailViewController(optionTitle: title)
        navigationController?.pushViewController(detailVC, animated: true)
    }
}
