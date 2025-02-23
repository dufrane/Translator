//
//  Model.swift
//  testProject
//
//  Created by Dmytro Vasylenko on 15.02.2025.
//

import Foundation

struct SettingsOption: Codable {
    let title: String
}

struct SettingsOptionData {
    static let options: [SettingsOption] = [
        SettingsOption(title: "Rate Us"),
        SettingsOption(title: "Share App"),
        SettingsOption(title: "Contact Us"),
        SettingsOption(title: "Restore Purchases"),
        SettingsOption(title: "Privacy Policy"),
        SettingsOption(title: "Terms of Use")
    ]
}
