//
//  SinglePlayerGameView.swift
//  ReVision
//
//  Created by Rahul Narayanan on 10/13/23.
//

import SwiftUI

struct SinglePlayerGameView: View {
    @ObservedObject var gameModel: GameModel
    @Binding var showingView: Bool
    @State private var location: String = ""
    @State private var showTimeOutAlert = false
    @State private var showGameOverAlert = false
    @State private var showGameWonAlert = false
    
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
                VStack {
                    Text("Instructions")
                        .font(.title)
                        .bold()
                        .underline()
                        .foregroundColor(.black)
                        .monospaced()
                        .multilineTextAlignment(.center)
                    Text("\n\nYou have 60 seconds for this challenge!")
                        .font(.title2)
                        .foregroundColor(.secondary)
                        .monospaced()
                        .multilineTextAlignment(.center)
                    Text("\nWhen prompted with a location, select the perfect match from the image options provided.\n\n")
                        .font(.title2)
                        .foregroundColor(.secondary)
                        .monospaced()
                        .multilineTextAlignment(.center)
                    Button("Begin Game") { gameModel.beginGame() }
                        .frame(width: 300, height: 60)
                        .bold()
                        .tint(.black)
                        .buttonStyle(.borderedProminent)
                }
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
        .onChange(of: gameModel.currentGameState) { newState in
            if newState == .timeOut {
                showTimeOutAlert = true
            } else if newState == .lost {
                showGameOverAlert = true
            } else if newState == .won {
                showGameWonAlert = true
            }
        }
        .alert("Time Out", isPresented: $showTimeOutAlert) {
            Button("Done") { showingView = false }
        } message: {
            Text("Time Out! Your score was \(gameModel.currentScore)")
        }
        .alert("Game Lost", isPresented: $showGameOverAlert) {
            Button("Done") { showingView = false }
        } message: {
            Text("Game Lost! Your score was \(gameModel.currentScore)")
        }
        .alert("Game Won", isPresented: $showGameWonAlert) {
            Button("Done") { showingView = false }
        } message: {
            Text("Game Won! Your score was \(gameModel.currentScore)")
        }
    }
}

//struct SinglePlayerGameView_Previews: PreviewProvider {
//    static var previews: some View {
//        SinglePlayerGameView(gameModel: GameModel(images: []))
//    }
//}
