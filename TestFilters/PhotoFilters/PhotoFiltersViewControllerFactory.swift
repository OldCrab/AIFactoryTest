//
//  PhotoFiltersViewControllerFactory.swift
//  TestFilters
//
//  Created by Andrew Vasiliev on 21.03.2020.
//  Copyright © 2020 Deepkotix. All rights reserved.
//

import UIKit

final class PhotoFiltersViewControllerFactory {
    func build(image: UIImage) -> PhotoFiltersViewController {
        return PhotoFiltersViewController(image: image)
    }
}
