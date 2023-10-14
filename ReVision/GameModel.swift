//
//  GameModel.swift
//  ReVision
//
//  Created by Rahul Narayanan on 10/13/23.
//

import SwiftUI

class GameModel: ObservableObject, Identifiable {
    static func == (lhs: GameModel, rhs: GameModel) -> Bool {
        lhs.allImages == rhs.allImages
    }
    
    struct ImageSet: Equatable {
        let imageSet: [ImageModel.UserImage]
        let correctImageIndex: Int
        
        func correctLocation() -> String {
            var name = ""
            imageSet[correctImageIndex].assetData.location?.lookUpPlacemarkName {
                name = $0?.name ?? "unknown"
            }
            
            return name
        }
    }
    
    enum GameState: String {
        case notStarted = "Not Started",
             inProgress = "In Progress",
             timeOut = "Time Out",
             lost = "Lost"
    }
    
    private static let maxTimeInSeconds: Int = 60
    private static let numberOfImagesInASet: Int = 4
    
    // MARK: - Properties
    private let allImages: [ImageModel.UserImage]
    
    private var timer: Timer?
    private var currentScore = 0
    private var imageSets: [ImageSet] = []
    private var currentImageSetIndex: Int = 0
    
    @Published var timerCount = 0
    @Published var currentGameState: GameState = .notStarted
    var currentImageSet: ImageSet {
        imageSets[currentImageSetIndex]
    }
    
    init(images: [ImageModel.UserImage]) {
        self.allImages = images
        resetGame()
    }
    
    // MARK: - User Intents
    func beginGame() {
        currentGameState = .inProgress
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: handleTimer)
    }
    
    func didSelectImage(_ image: ImageModel.UserImage) {
        guard let indexOfImage = currentImageSet.imageSet.firstIndex(of: image) else { return }
        if indexOfImage == currentImageSet.correctImageIndex {
            moveToNextSet()
        } else {
            gameLost()
        }
    }
    
    // MARK: - Private
    private func resetGame() {
        imageSets.removeAll()
        currentScore = 0
        timerCount = Self.maxTimeInSeconds
        currentImageSetIndex = 0
        currentGameState = .notStarted
        
        var shuffledImages = allImages.shuffled()
        while !shuffledImages.isEmpty {
            let imagesInSet = shuffledImages.prefix(Self.numberOfImagesInASet)
            var imageSet = ImageSet(imageSet: imagesInSet.shuffled(), correctImageIndex: Int.random(in: 0..<imagesInSet.count))
            if !imagesInSet.isEmpty {
//                var name = ""
//                DispatchQueue.main.async {
//                    imageSet.imageSet[imageSet.correctImageIndex].assetData.location?.lookUpPlacemarkName {
//                        name = $0?.name ?? "unknown"
//                    }
//                    imageSet.location = name
//                }
                imageSets.append(imageSet)
                print("correct index: \(imageSet.correctImageIndex)")
            }
            
            shuffledImages.removeFirst(min(Self.numberOfImagesInASet, shuffledImages.count))
        }
    }
    
    private func moveToNextSet() {
        if currentImageSetIndex + 1 < imageSets.count {
            currentImageSetIndex += 1
        } else {
            timeOut()
        }
    }
    
    private func gameLost() {
        currentGameState = .lost
        timer?.invalidate()
    }
    
    private func timeOut() {
        currentGameState = .timeOut
        timer?.invalidate()
    }
    
    private func handleTimer(_ timer: Timer) {
        self.timerCount -= 1
        if timerCount == 0 {
            timeOut()
        }
    }
}
