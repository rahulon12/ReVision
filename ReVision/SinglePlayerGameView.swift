//
//  SinglePlayerGameView.swift
//  ReVision
//
//  Created by Rahul Narayanan on 10/13/23.
//

import SwiftUI

struct SinglePlayerGameView: View {
    @ObservedObject var gameModel: GameModel
    @State private var location: String = ""
    
    var body: some View {
        VStack(spacing: 36) {
            if gameModel.currentGameState == .inProgress {
                VStack(spacing: 16) {
                    HStack {
                        Spacer()
                        
                        Text("\(gameModel.timerCount)")
                            .font(.title2)
                            .bold()
                            .foregroundColor(.secondary)
                            .monospaced()
                        
                        Spacer()
                    }
                    
                    Text("Location:\n\(location)")
                        .font(.title2)
                        .bold()
                        .foregroundColor(.blue)
                        .monospaced()
                        .lineLimit(2)
                        .multilineTextAlignment(.center)
                }
                .padding()
                                
                LazyVGrid(columns: [.init(.fixed(175)), .init(.fixed(175))], spacing: 4) {
                    ForEach(gameModel.currentImageSet.imageSet) { userImage in
                        Button {
                            gameModel.didSelectImage(userImage)
                        } label: {
                            Image(uiImage: userImage.image)
                                .resizable()
                                .clipShape(RoundedRectangle(cornerRadius: 8.0))
                                .frame(width: 175, height: 175)
                        }
                        .buttonStyle(SpringButton())
                    }
                }
                // ARGameView(gameModel: gameModel)
            }
            
            if gameModel.currentGameState == .notStarted {
                Button("Begin Game") { gameModel.beginGame() }
            }
        }
        .padding()
        .onAppear {
            gameModel.currentImageSet.imageSet[gameModel.currentImageSet.correctImageIndex].assetData.location?.lookUpPlacemarkName {
                location = $0?.name ?? "unknown"
            }
        }
        .onChange(of: gameModel.currentImageSet) { newSet in
            gameModel.currentImageSet.imageSet[gameModel.currentImageSet.correctImageIndex].assetData.location?.lookUpPlacemarkName {
                location = $0?.name ?? "unknown"
            }
        }
    }
}

//struct SinglePlayerGameView_Previews: PreviewProvider {
//    static var previews: some View {
//        SinglePlayerGameView(gameModel: GameModel(images: []))
//    }
//}
