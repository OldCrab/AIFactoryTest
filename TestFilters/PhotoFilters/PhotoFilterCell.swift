//
//  PhotoFilterCell.swift
//  TestFilters
//
//  Created by Andrew Vasiliev on 21.03.2020.
//  Copyright © 2020 Deepkotix. All rights reserved.
//

import UIKit

final class PhotoFilterCell: UICollectionViewCell {
    private let imageView = UIImageView()

    override init(frame: CGRect) {
        super.init(frame: frame)

        configureSelf()
        configureSubviews()
        addSubviews()
        setAutoresizingMasks()
        setConstraints()
    }

    func setImage(_ image: UIImage) {
        imageView.image = image
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension PhotoFilterCell {
    var allSubviews: [UIView] { return [imageView,] }

    func configureSelf() {
        backgroundColor = .white
    }

    func configureSubviews() {
        //        selectionLabel.text = "Click on image to select a photo"
        //        selectionLabel.textAlignment = .center
        //        selectionLabel.backgroundColor = .white
        //        selectionLabel.numberOfLines = 0
        //
        //        let image = #imageLiteral(resourceName: "Frame 102 (1)").image(size: CGSize(width: 100, height: 100), cornerRadius: 10)
        //        selectionButton.setImage(image, for: .normal)
        //        selectionButton.addTarget(self, action: #selector(didClickToChoosePhoto), for: .touchUpInside)
    }

    func addSubviews() {
        allSubviews.forEach(addSubview)
    }

    func setAutoresizingMasks() {
        allSubviews.forEach { $0.translatesAutoresizingMaskIntoConstraints = false }
    }

    func setConstraints() {
        let constraints: [NSLayoutConstraint] = [
            imageView.topAnchor.constraint(equalTo: topAnchor),
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            imageView.bottomAnchor.constraint(equalTo: bottomAnchor),
        ]

        NSLayoutConstraint.activate(constraints)
    }

}
