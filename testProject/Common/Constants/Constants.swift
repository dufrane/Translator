//
//  Constants.swift
//  testProject
//
//  Created by Dmytro Vasylenko on 17.02.2025.
//

import UIKit

enum AssetImages: String {
    case arrow
    case cat
    case chat
    case close
    case dog
    case microphone
    case settings

    var image: UIImage? {
        return UIImage(named: self.rawValue)
    }
}
