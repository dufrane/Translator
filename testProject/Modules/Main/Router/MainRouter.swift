//
//  MainRouter.swift
//  testProject
//
//  Created by Dmytro Vasylenko on 22.02.2025.
//

import UIKit

protocol MainRouterProtocol {
    func openResultScreen(with petImage: UIImage)
    func openSettingsScreen()
}

final class MainRouter: MainRouterProtocol {
    private weak var navigationController: UINavigationController?

    init(navigationController: UINavigationController?) {
        self.navigationController = navigationController
    }

    func start() {
        let mainVC = MainViewController()
        let presenter = MainPresenter(view: mainVC, router: self)
        mainVC.presenter = presenter
        navigationController?.viewControllers = [mainVC] // Встановлюємо root
    }

    func openResultScreen(with petImage: UIImage) {
        let resultRouter = ResultRouter(navigationController: navigationController)
        resultRouter.start(with: petImage)
    }

    func openSettingsScreen() {
        let settingsRouter = SettingsRouter(navigationController: navigationController)
        settingsRouter.start()
    }
}
