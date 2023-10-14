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
    @State private var gameModel: GameModel?
    @State private var showGameView = false
    
    var body: some View {
        VStack {
            PhotosPicker(selection: $viewModel.currentImageSelection, matching: .images, photoLibrary: .shared()) {
                Text("Select Photos")
            }
            
            Button("Show Game View") {
                showGameView = true
            }
            .disabled(!viewModel.doneAddingImages)
        }
        .onChange(of: viewModel.currentImages) { newVal in
            gameModel = GameModel(images: newVal)
        }
        .fullScreenCover(isPresented: $showGameView) {
            SinglePlayerGameView(gameModel: gameModel!, showingView: $showGameView)
        }
    }
}

struct PhotosSelector_Previews: PreviewProvider {
    static var previews: some View {
        PhotosSelector()
    }
}
