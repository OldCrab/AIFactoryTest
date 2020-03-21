//
//  PhotoFiltersView.swift
//  TestFilters
//
//  Created by Andrew Vasiliev on 21.03.2020.
//  Copyright © 2020 Deepkotix. All rights reserved.
//

import UIKit

final class PhotoFiltersView: CommonView {
    private let mainImageView = UIImageView()
    let filtersCollection = UICollectionView(
        frame: .zero,
        collectionViewLayout: PhotoFiltersCollectionLayout()
    )

    func setImage(_ image: UIImage) {
        mainImageView.image = image
    }

    override init() {
        super.init()

        configureSelf()
        configureSubviews()
        addSubviews()
        setAutoresizingMasks()
        setConstraints()
    }
}

extension PhotoFiltersView {
    var allSubviews: [UIView] { return [mainImageView, filtersCollection] }

    func configureSelf() {
        backgroundColor = .white
    }

    func configureSubviews() {
        filtersCollection.showsHorizontalScrollIndicator = false
        filtersCollection.showsVerticalScrollIndicator = false
        filtersCollection.backgroundColor = .white
    }

    func addSubviews() {
        allSubviews.forEach(addSubview)
    }

    func setAutoresizingMasks() {
        allSubviews.forEach { $0.translatesAutoresizingMaskIntoConstraints = false }
    }

    func setConstraints() {
        let bottomAnchor: NSLayoutYAxisAnchor
        let topAnchor: NSLayoutYAxisAnchor

        if #available(iOS 11.0, *) {
            bottomAnchor = safeAreaLayoutGuide.bottomAnchor
            topAnchor = safeAreaLayoutGuide.topAnchor
        } else {
            bottomAnchor = self.bottomAnchor
            topAnchor = self.topAnchor
        }

        let constraints: [NSLayoutConstraint] = [
            // Main Photo
            mainImageView.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            mainImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            mainImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            mainImageView.bottomAnchor.constraint(equalTo: filtersCollection.topAnchor, constant: -10),
            // Filters Collection View
            filtersCollection.leadingAnchor.constraint(equalTo: leadingAnchor),
            filtersCollection.trailingAnchor.constraint(equalTo: trailingAnchor),
            filtersCollection.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10),
            filtersCollection.heightAnchor.constraint(equalToConstant: 80),
        ]

        NSLayoutConstraint.activate(constraints)
    }
}
