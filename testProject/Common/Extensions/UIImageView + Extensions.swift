//
//  UIImageView + Extensions.swift
//  testProject
//
//  Created by Dmytro Vasylenko on 12.02.2025.
//

import UIKit
import ImageIO

extension UIImageView {
    func loadGif(named name: String) {
        guard let path = Bundle.main.path(forResource: name, ofType: "gif"),
              let gifData = try? Data(contentsOf: URL(fileURLWithPath: path)) else { return }

        let imageSource = CGImageSourceCreateWithData(gifData as CFData, nil)
        var images: [UIImage] = []

        let count = CGImageSourceGetCount(imageSource!)
        for i in 0..<count {
            if let cgImage = CGImageSourceCreateImageAtIndex(imageSource!, i, nil) {
                images.append(UIImage(cgImage: cgImage))
            }
        }

        self.animationImages = images
        self.animationDuration = Double(count) * 0.1
        self.startAnimating()
    }
}
