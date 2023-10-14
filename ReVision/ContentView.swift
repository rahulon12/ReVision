//
//  ContentView.swift
//  ReVision
//
//  Created by Rahul Narayanan on 10/13/23.
//

import SwiftUI
import PhotosUI
import CoreData

struct ContentView: View {
    @ObservedObject var viewModel: ImageModel = ImageModel()
    @State private var gameModel: GameModel?
    @State private var showGameView = false
    @State private var showARView = false
    
    var body: some View {
        NavigationView {
            ZStack {
                AnimatedGradient()
                    .edgesIgnoringSafeArea(.all)
                VStack {
                    Image("Logo")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 300)
                    
                    PhotosPicker(selection: $viewModel.currentImageSelection, matching: .images, photoLibrary: .shared()) {
                        Text("Select Photos")
                            .frame(width: 300, height: 60)
                            .bold()
                    }
                    .tint(.black)
                    .buttonStyle(.borderedProminent)
                    
                    Button {
                        gameModel = GameModel(images: viewModel.currentImages)
                        showGameView = true
                    } label: {
                        Text("Play Game")
                            .frame(width: 300, height:60)
                            .bold()
                    }
                    .tint(.black)
                    .buttonStyle(.borderedProminent)
                    .disabled(!viewModel.doneAddingImages)
                    
                    Button {
                        showARView = true
                    } label: {
                        Text("Gallery")
                            .frame(width: 300, height:60)
                            .bold()
                    }
                    .tint(.black)
                    .buttonStyle(.borderedProminent)
                    .disabled(!viewModel.doneAddingImages)
                }
            }
        }
        .onChange(of: viewModel.currentImages) { newVal in
            gameModel = GameModel(images: newVal)
        }
        .fullScreenCover(isPresented: $showGameView) {
            SinglePlayerGameView(gameModel: gameModel!)
        }
        .fullScreenCover(isPresented: $showARView) {
            ARGameView(gameModel: gameModel!)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
