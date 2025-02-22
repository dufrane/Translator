//
//  PetSelectionView.swift
//  testProject
//
//  Created by Dmytro Vasylenko on 09.02.2025.
//

import UIKit

protocol PetSelectionViewDelegate: AnyObject {
    func didSelectPet(image: UIImage?)
}

class PetSelectionView: UIView {

    weak var delegate: PetSelectionViewDelegate?
    private var isCatSelected = true

    private var rectView: UIView = {
        let view = UIView()
        view.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        view.layer.cornerRadius = 16
        view.alpha = 1.0
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private let blueSquare: UIView = {
        let view = UIView()
        view.backgroundColor = #colorLiteral(red: 0.8196078431, green: 0.9058823529, blue: 0.9882352941, alpha: 1)
        view.layer.cornerRadius = 8
        view.alpha = 1.0
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private let greenSquare: UIView = {
        let view = UIView()
        view.backgroundColor = #colorLiteral(red: 0.9254901961, green: 0.9843137255, blue: 0.7803921569, alpha: 1)
        view.layer.cornerRadius = 8
        view.alpha = 0.6
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let catImageIconView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "cat")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let dogImageIconView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "dog")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setConstraints()
        addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(viewTapped)))
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupViews() {
        backgroundColor = .white
   

        addSubview(rectView)
        rectView.addSubview(blueSquare)
        rectView.addSubview(greenSquare)
        blueSquare.addSubview(catImageIconView)
        greenSquare.addSubview(dogImageIconView)
    }

    private func setConstraints() {
        NSLayoutConstraint.activate([
            rectView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            rectView.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            rectView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            rectView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10)
        ])

        NSLayoutConstraint.activate([
            blueSquare.leadingAnchor
                .constraint(equalTo: leadingAnchor, constant: 12),
            blueSquare.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            blueSquare.heightAnchor.constraint(equalToConstant: 70),
            blueSquare.widthAnchor.constraint(equalToConstant: 83)
        ])

        NSLayoutConstraint.activate([
            greenSquare.leadingAnchor
                .constraint(equalTo: leadingAnchor, constant: 12),
            greenSquare.bottomAnchor
                .constraint(equalTo: bottomAnchor, constant: -10),
            greenSquare.widthAnchor.constraint(equalToConstant: 83),
            greenSquare.heightAnchor.constraint(equalToConstant: 70)
        ])
        
        NSLayoutConstraint.activate([
            catImageIconView.centerXAnchor.constraint(equalTo: blueSquare.centerXAnchor),
            catImageIconView.centerYAnchor.constraint(equalTo: blueSquare.centerYAnchor),
            catImageIconView.widthAnchor.constraint(equalToConstant: 40),
            catImageIconView.heightAnchor.constraint(equalToConstant: 40)
        ])
        
        NSLayoutConstraint.activate([
            dogImageIconView.centerXAnchor.constraint(equalTo: greenSquare.centerXAnchor),
            dogImageIconView.centerYAnchor.constraint(equalTo: greenSquare.centerYAnchor),
            dogImageIconView.widthAnchor.constraint(equalToConstant: 40),
            dogImageIconView.heightAnchor.constraint(equalToConstant: 40)
        ])
    }

    @objc private func viewTapped() {
        isCatSelected.toggle()
        UIView.animate(withDuration: 0.3) {
            self.blueSquare.alpha = self.isCatSelected ? 1.0 : 0.6
            self.greenSquare.alpha = self.isCatSelected ? 0.6 : 1.0
        }
        let selectedImage = isCatSelected ? AssetImages.cat.image : AssetImages.dog.image
        delegate?.didSelectPet(image: selectedImage)
    }
}
