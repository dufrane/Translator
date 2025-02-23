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
    func saveSettingsOptions(_ options: [SettingsOption])
}

final class SettingsPresenter: SettingsPresenterProtocol {
    private weak var view: SettingsViewProtocol?
    private let router: SettingsRouterProtocol
    private let settingsKey = "settingsOptions"

    init(view: SettingsViewProtocol, router: SettingsRouterProtocol) {
        self.view = view
        self.router = router
        saveDefaultSettingsIfNeeded()
    }

    func getSettingsOptions() -> [SettingsOption] {
        if let savedOptions = loadSettingsOptions() {
            return savedOptions
        }
        return SettingsOptionData.options
    }

    func didSelectOption(_ option: SettingsOption) {
        print("OPtion selected: \(option.title)")
        router.navigateToDetailScreen(with: option.title)
    }

    func saveSettingsOptions(_ options: [SettingsOption]) {
        let encoder = JSONEncoder()
        if let encodedData = try? encoder.encode(options) {
            UserDefaults.standard.set(encodedData, forKey: settingsKey)
        }
    }

    private func loadSettingsOptions() -> [SettingsOption]? {
        if let savedData = UserDefaults.standard.data(forKey: settingsKey) {
            let decoder = JSONDecoder()
            if let savedOptions = try? decoder.decode([SettingsOption].self, from: savedData) {
                return savedOptions
            }
        }
        return nil
    }

    private func saveDefaultSettingsIfNeeded() {
        if UserDefaults.standard.data(forKey: settingsKey) == nil {
            saveSettingsOptions(SettingsOptionData.options)
        }
    }
}
