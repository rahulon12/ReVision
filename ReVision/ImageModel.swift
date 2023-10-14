//
//  ImageModel.swift
//  ReVision
//
//  Created by Rahul Narayanan on 10/13/23.
//

import SwiftUI
import PhotosUI
import CoreTransferable

@MainActor
class ImageModel: ObservableObject {
    
    @Published var currentImages: [UserImage] = []
    @Published var currentImageSelection: [PhotosPickerItem] = [] {
        didSet {
            currentImages = []
            currentImageSelection.forEach({ item in
                let _ = loadTransferable(from: item)
            })
        }
    }
    
    struct UserImage: Identifiable {
        let id: String
        let image: UIImage
        let assetData: PHAsset
    }
    
    private func loadTransferable(from imageSelection: PhotosPickerItem) -> Progress {
        return imageSelection.loadTransferable(type: Data.self) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let imageData):
                    if let imageData {
                        if let localID = imageSelection.itemIdentifier {
                            let result = PHAsset.fetchAssets(withLocalIdentifiers: [localID], options: nil)
                            if let asset = result.firstObject {
                                self.currentImages.append(
                                    UserImage(id: localID,
                                              image: UIImage(data: imageData)!,
                                              assetData: asset)
                                )
                            }
                        }
                    } else {
                        print("No supported content type found.")
                    }
                case .failure(let error):
                    print(error)
                }
            }
        }
    }
}
