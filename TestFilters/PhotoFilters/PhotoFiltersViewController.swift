//
//  PhotoFiltersViewController.swift
//  TestFilters
//
//  Created by Andrew Vasiliev on 21.03.2020.
//  Copyright © 2020 Deepkotix. All rights reserved.
//

import UIKit

final class PhotoFiltersViewController: CommonViewController {
    private lazy var mainView = PhotoFiltersView()

    private let filterNames = [
        "CIColorCrossPolynomial",
        "CIColorCube",
        "CIColorCubeWithColorSpace",
        "CIColorInvert",
        "CIColorMap",
        "CIColorMonochrome",
        "CIColorPosterize",
        "CIFalseColor",
        "CIMaskToAlpha",
        "CIMaximumComponent",
        "CIMinimumComponent",
        "CIPhotoEffectChrome",
        "CIPhotoEffectFade",
        "CIPhotoEffectInstant",
        "CIPhotoEffectMono",
        "CIPhotoEffectNoir",
        "CIPhotoEffectProcess",
        "CIPhotoEffectTonal",
        "CIPhotoEffectTransfer",
        "CISepiaTone",
        "CIVignette",
        "CIVignetteEffect",
    ]

    private var filters: [String : CIFilter] = [:]
    private let ciContext = CIContext()

    private let originalImage: UIImage
    private let miniImage: UIImage

    private let addingQueue = DispatchQueue(label: "addingFilters", qos: .default)

    init(image: UIImage) {
        originalImage = image
        miniImage = image.image(size: CGSize(width: 68, height: 68), cornerRadius: 5) ?? image

        super.init()
    }

    override func loadView() {
        super.loadView()

        view = mainView
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        mainView.filtersCollection.delegate = self
        mainView.filtersCollection.dataSource = self
        mainView.filtersCollection.register(PhotoFilterCell.self, forCellWithReuseIdentifier: "Cell")
        mainView.setImage(originalImage)
    }
}

extension PhotoFiltersViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        getFilter(number: indexPath.item) { filter in
            guard let filter = filter else { return assertionFailure() }

            DispatchQueue.global(qos: .background).async {
                let image = self.addFilter(to: self.originalImage, filter: filter)
                DispatchQueue.main.async {
                    self.mainView.setImage(image)
                }
            }
        }
    }
}

extension PhotoFiltersViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return filterNames.count
    }

    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        guard
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as? PhotoFilterCell else {
            fatalError()
        }

        getFilter(number: indexPath.item) { filter in
            guard let filter = filter else {
                DispatchQueue.main.async {
                    cell.setImage(self.miniImage)
                }

                return
            }

            DispatchQueue.global(qos: .background).async {
                let image = self.addFilter(to: self.miniImage, filter: filter)
                DispatchQueue.main.async {
                    cell.setImage(image)
                }
            }
        }

        return cell
    }

    func getFilter(number: Int, completionHandler: @escaping Action<CIFilter?>) {
        let name = filterNames[number]

        if let filter = filters[name] {
            completionHandler(filter)
        } else {
            DispatchQueue.global(qos: .background).async {
                guard let filter = CIFilter(name: name) else { return completionHandler(nil) }

                self.addingQueue.async {
                    self.filters[name] = filter
                }

                completionHandler(filter)
            }
        }
    }

    func addFilter(to original: UIImage, filter: CIFilter) -> UIImage {
        let ciInput = CIImage(image: original)
        filter.setValue(ciInput, forKey: kCIInputImageKey)
        guard
            let ciOutput = filter.outputImage,
            let cgImage = ciContext.createCGImage(ciOutput, from: ciOutput.extent) else
        {
            return original
        }

        return UIImage(cgImage: cgImage)
    }
}
