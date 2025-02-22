//
//  MicrophoneButton.swift
//  testProject
//
//  Created by Dmytro Vasylenko on 09.02.2025.
//
import UIKit
import AVFoundation

protocol MicrophoneViewDelegate: AnyObject {
    func didStartRecording()
    func didStopRecording()
}

class MicrophoneView: UIView {

    weak var delegate: MicrophoneViewDelegate?
    private var isRecording = false

    private let micImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = AssetImages.microphone.image
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Start Speak"
        label.font = .konchmerNormal16()
        label.textColor = .specialText
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let recordingGifView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.isHidden = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupViews()
    }

    private func setupViews() {
        backgroundColor = .white
        layer.cornerRadius = 16

        addSubview(micImageView)
        addSubview(titleLabel)
        addSubview(recordingGifView)

        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(viewTapped))
        addGestureRecognizer(tapGesture)

        setConstraints()
    }

    private func setConstraints() {
        NSLayoutConstraint.activate([
            micImageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            micImageView.topAnchor.constraint(equalTo: topAnchor, constant: 44),
            micImageView.widthAnchor.constraint(equalToConstant: 70),
            micImageView.heightAnchor.constraint(equalToConstant: 70)
            ])
            
            NSLayoutConstraint.activate([
            recordingGifView.centerXAnchor.constraint(equalTo: centerXAnchor),
            recordingGifView.topAnchor.constraint(equalTo: topAnchor, constant: 19),
            recordingGifView.widthAnchor.constraint(equalToConstant: 163),
            recordingGifView.heightAnchor.constraint(equalToConstant: 95)
            ])

            NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: micImageView.bottomAnchor, constant: 24),
            titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            titleLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16)
        ])
    }

    @objc private func viewTapped() {
        requestMicrophoneAccess()
    }

    private func requestMicrophoneAccess() {
        AVAudioSession.sharedInstance().requestRecordPermission { [weak self] granted in
            DispatchQueue.main.async {
                if granted {
                    self?.toggleRecording()
                } else {
                    self?.showMicrophoneAccessAlert()
                }
            }
        }
    }

    private func toggleRecording() {
        isRecording.toggle()

        if isRecording {
            startRecording()
        } else {
            stopRecording()
        }
    }

    private func startRecording() {
        micImageView.isHidden = true
        recordingGifView.isHidden = false
        recordingGifView.loadGif(named: "bitrate")

        titleLabel.text = "Recording..."
        delegate?.didStartRecording()
    }

    private func stopRecording() {
        micImageView.isHidden = false
        recordingGifView.isHidden = true

        titleLabel.text = "Start Speak"
        delegate?.didStopRecording()
    }

    private func showMicrophoneAccessAlert() {
        guard let rootVC = UIApplication.shared.keyWindow?.rootViewController else { return }

        let alert = UIAlertController(title: "Enable Microphone Access",
                                      message: "Please enable microphone access in settings to use this feature.",
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "Settings", style: .default) { _ in
            if let appSettings = URL(string: UIApplication.openSettingsURLString) {
                UIApplication.shared.open(appSettings)
            }
        })

        rootVC.present(alert, animated: true)
    }
}
