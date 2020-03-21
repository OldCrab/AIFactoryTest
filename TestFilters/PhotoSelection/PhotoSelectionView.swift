//
//  PhotoSelectionView.swift
//  TestFilters
//
//  Created by Andrew Vasiliev on 21.03.2020.
//  Copyright © 2020 Deepkotix. All rights reserved.
//

import UIKit

final class PhotoSelectionView: CommonView {
    private let selectionLabel = UILabel()
    private let selectionButton = UIButton()

    private var didClickToChoosePhotoHandler: VoidAction?

    override init() {
        super.init()

        configureSelf()
        configureSubviews()
        addSubviews()
        setAutoresizingMasks()
        setConstraints()
    }

    func setDidClickToChoosePhoto(handler: VoidAction?) {
        didClickToChoosePhotoHandler = handler
    }
}

private extension PhotoSelectionView {
    var allSubviews: [UIView] { return [selectionLabel, selectionButton] }

    func configureSelf() {
        backgroundColor = .white
    }

    func configureSubviews() {
        selectionLabel.text = "Click on image to select a photo"
        selectionLabel.textAlignment = .center
        selectionLabel.backgroundColor = .white
        selectionLabel.numberOfLines = 0

        let image = #imageLiteral(resourceName: "Frame 102 (1)").image(size: CGSize(width: 100, height: 100), cornerRadius: 10)
        selectionButton.setImage(image, for: .normal)
        selectionButton.addTarget(self, action: #selector(didClickToChoosePhoto), for: .touchUpInside)
    }

    func addSubviews() {
        allSubviews.forEach(addSubview)
    }

    func setAutoresizingMasks() {
        allSubviews.forEach { $0.translatesAutoresizingMaskIntoConstraints = false }
    }

    func setConstraints() {
        let constraints: [NSLayoutConstraint] = [
            // Label
            selectionLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 30),
            selectionLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -30),
            selectionLabel.bottomAnchor.constraint(equalTo: selectionButton.topAnchor, constant: -10),
            // Button
            selectionButton.widthAnchor.constraint(equalToConstant: 100),
            selectionButton.heightAnchor.constraint(equalTo: selectionButton.widthAnchor),
            selectionButton.centerYAnchor.constraint(equalTo: centerYAnchor),
            selectionButton.centerXAnchor.constraint(equalTo: centerXAnchor),
        ]

        NSLayoutConstraint.activate(constraints)
    }

    @objc
    func didClickToChoosePhoto() {
        didClickToChoosePhotoHandler?()
    }
}
