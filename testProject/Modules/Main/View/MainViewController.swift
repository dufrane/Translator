//
//  ViewController.swift
//  testProject
//
//  Created by Dmytro Vasylenko on 06.02.2025.
//

import UIKit
import AVFoundation

protocol MainViewProtocol: AnyObject {
    func updatePetImage(_ image: UIImage)
    func showMicrophoneAccessAlert()
}

class MainViewController: UIViewController, MainViewProtocol {

    private var recordingSession: AVAudioSession!
    private var audioRecorder: AVAudioRecorder!
    
    var presenter: MainPresenterProtocol?
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Translator"
        label.textAlignment = .center
        label.font = .konchmerNormal32()
        label.textColor = .specialText
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let petButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("PET", for: .normal)
        button.titleLabel?.font = .konchmerNormal16()
        button.setTitleColor(.specialText, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let microphoneButton = MicrophoneView()
    private let petSelectionView = PetSelectionView()

    private let largePetImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = AssetImages.cat.image
        imageView.layer.cornerRadius = 16
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let bottomNavigationView = BottomNavigationView()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .specialBackground

        petSelectionView.delegate = self
        bottomNavigationView.delegate = self
        microphoneButton.delegate = self

        setupSubviews()
        setConstraints()
    }

    private func setupSubviews() {
        view.addSubview(titleLabel)
        view.addSubview(petButton)
        view.addSubview(microphoneButton)
        view.addSubview(petSelectionView)
        view.addSubview(largePetImageView)
        view.addSubview(bottomNavigationView)
        
        microphoneButton.addShaddowOnView()
        petSelectionView.addShaddowOnView()
        bottomNavigationView.addShaddowOnView()
        
        microphoneButton.translatesAutoresizingMaskIntoConstraints = false
        petSelectionView.translatesAutoresizingMaskIntoConstraints = false
        bottomNavigationView.translatesAutoresizingMaskIntoConstraints = false
        petButton.addTarget(self, action: #selector(didTapPetHumanButton), for: .touchUpInside)
    }

    @objc private func didTapPetHumanButton() {
        print("Pet Human button tapped")
    }

    // MARK: - MainViewProtocol
    func updatePetImage(_ image: UIImage) {
        DispatchQueue.main.async {
            self.largePetImageView.image = image
        }
    }

    func showMicrophoneAccessAlert() {
        let alert = UIAlertController(title: "Enable Microphone Access",
                                      message: "Please enable microphone access in settings.",
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
}

// MARK: - Delegates
extension MainViewController: PetSelectionViewDelegate, BottomNavigationViewDelegate, MicrophoneViewDelegate {
    
    func didStartRecording() {
        print("Recording started...")
    }

    func didStopRecording() {
        guard let selectedPetImage = self.largePetImageView.image else {
            print("Error: did not found animal image!")
            return
        }
        presenter?.recordingStopped(with: selectedPetImage)
    }

    func didSelectPet(image: UIImage?) {
        guard let image = image else { return }
        presenter?.petSelected(image: image)
    }

    func didTapTranslator() {
        navigationController?.popToRootViewController(animated: true)
    }
    
    func didTapSettings() {
        presenter?.openSettings()
    }
}

// MARK: - Layout Constraints
extension MainViewController {
    private func setConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 80),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            titleLabel.heightAnchor.constraint(equalToConstant: 58)
        ])

        NSLayoutConstraint.activate([
            petButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 76.5),
            petButton.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 12)
        ])
        
        NSLayoutConstraint.activate([
            microphoneButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 35),
            microphoneButton.topAnchor.constraint(equalTo: petButton.bottomAnchor, constant: 58),
            microphoneButton.widthAnchor.constraint(equalToConstant: 178),
            microphoneButton.heightAnchor.constraint(equalToConstant: 176)
        ])

        NSLayoutConstraint.activate([
            petSelectionView.leadingAnchor.constraint(equalTo: microphoneButton.trailingAnchor, constant: 35),
            petSelectionView.topAnchor.constraint(equalTo: petButton.bottomAnchor, constant: 58),
            petSelectionView.heightAnchor.constraint(greaterThanOrEqualToConstant: 176),
            petSelectionView.widthAnchor.constraint(greaterThanOrEqualToConstant: 107)
        ])
        
        NSLayoutConstraint.activate([
            largePetImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            largePetImageView.topAnchor.constraint(equalTo: microphoneButton.bottomAnchor, constant: 51),
            largePetImageView.widthAnchor.constraint(equalToConstant: 184),
            largePetImageView.heightAnchor.constraint(equalToConstant: 184)
        ])
        
        NSLayoutConstraint.activate([
            bottomNavigationView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 87),
            bottomNavigationView.widthAnchor.constraint(equalToConstant: 216),
            bottomNavigationView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16),
            bottomNavigationView.heightAnchor.constraint(equalToConstant: 82)
        ])
    }
}
