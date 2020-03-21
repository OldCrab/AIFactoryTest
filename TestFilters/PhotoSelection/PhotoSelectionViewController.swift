//
//  PhotoSelectionViewController.swift
//  TestFilters
//
//  Created by Andrew Vasiliev on 21.03.2020.
//  Copyright © 2020 Deepkotix. All rights reserved.
//

import UIKit

final class PhotoSelectionViewController: CommonViewController {
    private lazy var mainView = PhotoSelectionView()

    private let filtersViewControllerFactory: PhotoFiltersViewControllerFactory
    private var picker: UIImagePickerController = UIImagePickerController()

    init(filtersViewControllerFactory: PhotoFiltersViewControllerFactory) {
        self.filtersViewControllerFactory = filtersViewControllerFactory

        super.init()

        picker.delegate = self
    }

    override func loadView() {
        super.loadView()

        view = mainView
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        let handler = weakify(owner: self, function: PhotoSelectionViewController.chooseButtonTapped)
        mainView.setDidClickToChoosePhoto(handler: handler)
    }

    func chooseButtonTapped() {
        let alertController = createPhotoSourceAlert()

        present(alertController, animated: true, completion: nil)
    }
}

extension PhotoSelectionViewController: UIImagePickerControllerDelegate {
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }

    func imagePickerController(
        _ picker: UIImagePickerController,
        didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]
    ) {
        guard let chosenImage = info[.originalImage] as? UIImage else { return assertionFailure("no photo") }

        picker.dismiss(animated: true) {
            let viewController = self.filtersViewControllerFactory.build(image: chosenImage)
            self.navigationController?.pushViewController(viewController, animated: true)
        }
    }
}

extension PhotoSelectionViewController: UINavigationControllerDelegate {

}

private extension PhotoSelectionViewController {
    func createPhotoSourceAlert() -> UIAlertController {
        let alertController = UIAlertController(
            title: nil,
            message: nil,
            preferredStyle: .actionSheet
        )

        let galleryAction = UIAlertAction(
            title: "Open Gallery",
            style: .default,
            handler: openGallary
        )

        let photoAction = UIAlertAction(
            title: "Take Photo",
            style: .default,
            handler: takePhoto
        )

        let cancelAction = UIAlertAction(
            title: "Cancel",
            style: .cancel
        )

        alertController.addAction(galleryAction)
        alertController.addAction(photoAction)
        alertController.addAction(cancelAction)

        return alertController
    }

    func openGallary(alerAction: UIAlertAction) {
        picker.allowsEditing = false
        picker.sourceType = .photoLibrary

        present(picker, animated: true)
    }

    func takePhoto(alerAction: UIAlertAction) {
        openCamera()
    }

    func openCamera() {
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            picker.allowsEditing = false
            picker.sourceType = .camera
            picker.cameraCaptureMode = .photo
            present(picker, animated: true)
        } else {
            let alert = UIAlertController(
                title: "Camera Not Found",
                message: "This device has no Camera",
                preferredStyle: .alert
            )
            let ok = UIAlertAction(title: "OK", style: .default, handler: nil)
            alert.addAction(ok)
            present(alert, animated: true, completion: nil)
        }
    }
}
