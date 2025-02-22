//
//  MainPresenter.swift
//  testProject
//
//  Created by Dmytro Vasylenko on 13.02.2025.
//

import Foundation

import UIKit

protocol MainPresenterProtocol {
    func recordingStopped(with image: UIImage)
}

final class MainPresenter: MainPresenterProtocol {
    weak var view: MainViewProtocol?
    
    init(view: MainViewProtocol) {
        self.view = view
    }
    
    func petSelected(image: UIImage) {
        view?.updatePetImage(image)
    }
    
    func microphoneAccessDenied() {
        view?.showMicrophoneAccessAlert()
    }

    func recordingStopped(with image: UIImage) {
        let resultVC = ResultViewController(petImage: image)
        (view as? UIViewController)?.navigationController?.pushViewController(resultVC, animated: true)
    }
}


