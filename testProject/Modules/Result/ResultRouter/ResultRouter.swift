//
//  ResultRouter.swift
//  testProject
//
//  Created by Dmytro Vasylenko on 22.02.2025.
//

import UIKit

protocol ResultRouterProtocol {
    func start(with petImage: UIImage)
}

final class ResultRouter: ResultRouterProtocol {
    private weak var navigationController: UINavigationController?

    init(navigationController: UINavigationController?) {
        self.navigationController = navigationController
    }

    func start(with petImage: UIImage) {
        let resultVC = ResultViewController(petImage: petImage)
        navigationController?.pushViewController(resultVC, animated: true)
    }
}

