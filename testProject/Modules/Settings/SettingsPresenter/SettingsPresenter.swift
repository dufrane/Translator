//
//  SettingsPresenter.swift
//  testProject
//
//  Created by Dmytro Vasylenko on 15.02.2025.
//

import Foundation

protocol SettingsPresenterProtocol {
    func getSettingsOptions() -> [SettingsOption]
    func didSelectOption(_ option: SettingsOption)
}

final class SettingsPresenter: SettingsPresenterProtocol {

    private weak var view: SettingsViewProtocol?

    init(view: SettingsViewProtocol) {
        self.view = view
    }
    
    func getSettingsOptions() -> [SettingsOption] {
           return SettingsOptionData.options
       }
    
    func didSelectOption(_ option: SettingsOption) {
            view?.showDetailScreen(with: option.title)
        }
    
}
