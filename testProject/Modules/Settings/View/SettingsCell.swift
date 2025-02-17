//
//  SettingsCell.swift
//  testProject
//
//  Created by Dmytro Vasylenko on 12.02.2025.
//

import UIKit

class SettingsCell: UITableViewCell {
    
    private let cellView: UIView = {
        let view = UIView()
        view.backgroundColor = .specialViolet
        view.layer.cornerRadius = 20
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .konchmerNormal16()
        label.textColor = .specialText
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let arrowImageView: UIImageView = {
            let imageView = UIImageView()
            imageView.image = UIImage(systemName: "chevron.right")
            imageView.tintColor = .specialText
            imageView.translatesAutoresizingMaskIntoConstraints = false
            return imageView
        }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .specialBackground
        selectionStyle = .none
        setupViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupViews() {
        addSubview(cellView)
        cellView.addSubview(titleLabel)
        cellView.addSubview(arrowImageView)

        NSLayoutConstraint.activate([
            cellView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0),
            cellView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0),
            cellView.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        NSLayoutConstraint.activate([
            arrowImageView.trailingAnchor.constraint(equalTo: cellView.trailingAnchor, constant: -13),
            arrowImageView.centerYAnchor.constraint(equalTo: cellView.centerYAnchor),
            arrowImageView.heightAnchor.constraint(equalToConstant: 24)
        ])
        
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: cellView.leadingAnchor, constant: 20),
            titleLabel.centerYAnchor.constraint(equalTo: cellView.centerYAnchor)
        ])
    }

    func configure(with title: String) {
        titleLabel.text = title
    }
}
