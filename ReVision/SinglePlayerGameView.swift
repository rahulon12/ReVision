//
//  SinglePlayerGameView.swift
//  ReVision
//
//  Created by Rahul Narayanan on 10/13/23.
//

import SwiftUI

struct SinglePlayerGameView: View {
    @ObservedObject var gameModel: GameModel
    
    var body: some View {
        VStack {
            Text("\(gameModel.timerCount)")
            Text("State: \(gameModel.currentGameState.rawValue)")
            Text("Index: \(gameModel.currentImageSet.correctImageIndex)")
            
            if gameModel.currentGameState == .inProgress {
                Text("Location: \(gameModel.currentImageSet.correctLocation)")
                
                LazyVGrid(columns: [.init(.fixed(200)), .init(.fixed(200))]) {
                    ForEach(gameModel.currentImageSet.imageSet) { userImage in
                        Image(uiImage: userImage.image)
                            .resizable()
                            .clipShape(RoundedRectangle(cornerRadius: 8.0))
                            .frame(width: 200, height: 200)
                            .overlay {
                                Text("\(gameModel.currentImageSet.imageSet.firstIndex(of: userImage) ?? 0)")
                            }
                            .onTapGesture {
                                print("tapped index \(gameModel.currentImageSet.imageSet.firstIndex(of: userImage))")
                                gameModel.didSelectImage(userImage)
                            }
                    }
                }
            }
            
            if gameModel.currentGameState == .notStarted {
                Button("Begin Game") { gameModel.beginGame() }
            }
        }
        .padding()
        .onChange(of: gameModel.currentImageSet) { newSet in
            print("currently showing: \(newSet)")
        }
    }
}

struct SinglePlayerGameView_Previews: PreviewProvider {
    static var previews: some View {
        SinglePlayerGameView(gameModel: GameModel(images: []))
    }
}
