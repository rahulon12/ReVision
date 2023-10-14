//
//  PhotosPicker.swift
//  ReVision
//
//  Created by Rahul Narayanan on 10/13/23.
//

import SwiftUI
import PhotosUI

struct PhotosSelector: View {
    @ObservedObject var viewModel: ImageModel = ImageModel()
    
    var body: some View {
        VStack {
            PhotosPicker(selection: $viewModel.currentImageSelection, matching: .images, photoLibrary: .shared()) {
                Text("Select Photos")
            }
            
            ForEach(viewModel.currentImages) { image in
                Image(uiImage: image.image)
                    .resizable()
                    .frame(width: 250, height: 250)
                    .clipShape(RoundedRectangle(cornerRadius: 8.0))
                    .overlay(alignment: .bottom) {
                        GeometryReader { geo in
                            ZStack {
                                RoundedRectangle(cornerRadius: 8.0)
                                    .fill(.ultraThinMaterial)
                                Text("\(image.assetData.creationDate?.description ?? "")")
                            }
                            .frame(width: geo.size.width - 20, height: 20)
                        }
                    }
            }
        }
    }
}

struct PhotosSelector_Previews: PreviewProvider {
    static var previews: some View {
        PhotosSelector()
    }
}
