//
//  MainPresenter.swift
//  testProject
//
//  Created by Dmytro Vasylenko on 13.02.2025.
//

import UIKit

protocol MainPresenterProtocol {
    func petSelected(image: UIImage)
    func microphoneAccessDenied()
    func recordingStopped(with image: UIImage)
    func openSettings()
}


final class MainPresenter: MainPresenterProtocol {
    weak var view: MainViewProtocol?
    private let router: MainRouterProtocol

    init(view: MainViewProtocol, router: MainRouterProtocol) {
        self.view = view
        self.router = router
    }

    func petSelected(image: UIImage) {
        view?.updatePetImage(image)
    }

    func microphoneAccessDenied() {
        view?.showMicrophoneAccessAlert()
    }

    func recordingStopped(with image: UIImage) {
        router.openResultScreen(with: image)
    }

    func openSettings() {
        router.openSettingsScreen()
    }
}


