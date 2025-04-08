//
//  AppRouter.swift
//  testProject
//
//  Created by Dmytro Vasylenko on 22.02.2025.
//

import UIKit

protocol AppRouterProtocol {
    func start()
}

final class AppRouter: AppRouterProtocol {
    private let navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        let mainRouter = MainRouter(navigationController: navigationController)
        mainRouter.start()
    }
}
