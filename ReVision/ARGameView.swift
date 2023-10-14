//
//  ARGameView.swift
//  ReVision
//
//  Created by Rahul Narayanan on 10/14/23.
//

import SwiftUI
import UIKit
import ARKit
import RealityKit

struct ARGameView: UIViewControllerRepresentable {
    typealias UIViewControllerType = ARGameViewController
    var gameModel: GameModel
    
    func makeUIViewController(context: Context) -> ARGameViewController {
        let vc = ARGameViewController()
        vc.gameModel = gameModel
        return vc
    }
    
    func updateUIViewController(_ uiViewController: ARGameViewController, context: Context) {
        
    }
}

class ARGameViewController: UIViewController, ARSessionDelegate {
    
    private var arView: ARView!
    var gameModel: GameModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        arView = ARView(frame: self.view.frame)
        arView.session.delegate = self
        
        self.view.addSubview(arView)
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        self.view.backgroundColor = .green
    }
        
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        
        let location = touch.location(in: arView)
        
        let raycastResults = arView.raycast(from: location, allowing: .estimatedPlane, alignment: .horizontal)
        if let firstResult = raycastResults.first {
            let anchor1 = PictureAnchor(name: "0", transform: alterTransform(firstResult.worldTransform, delta: 0))
            anchor1.image = gameModel?.currentImageSet.imageSet[0].image
            arView.session.add(anchor: anchor1)
            
            let anchor2 = PictureAnchor(name: "1", transform: alterTransform(firstResult.worldTransform, delta: 0.5))
            anchor2.image = gameModel?.currentImageSet.imageSet[1].image
            arView.session.add(anchor: anchor2)
            
            let anchor3 = PictureAnchor(name: "2", transform: alterTransform(firstResult.worldTransform, delta: 1))
            anchor3.image = gameModel?.currentImageSet.imageSet[2].image
            arView.session.add(anchor: anchor3)
            
            let anchor4 = PictureAnchor(name: "3", transform: alterTransform(firstResult.worldTransform, delta: 1.5))
            anchor4.image = gameModel?.currentImageSet.imageSet[3].image
            arView.session.add(anchor: anchor4)
            
            print("Successfully added anchor")
        }
    }
    
    func alterTransform(_ transform: simd_float4x4, delta: Float) -> simd_float4x4 {
        var newTransform = transform
        newTransform.columns.3.x += delta
        return newTransform
    }
    
    func session(_ session: ARSession, didAdd anchors: [ARAnchor]) {
        for anchor in anchors {
            if let pictureAnchor = anchor as? PictureAnchor, let image = pictureAnchor.image, let imageAnchor = createImage(image, name: anchor.name!) {
                let stroke = AnchorEntity(anchor: anchor)
                stroke.addChild(imageAnchor)
                arView.scene.addAnchor(stroke)
            }
        }
    }
    
    private func createImage(_ image: UIImage, name: String) -> ModelEntity? {
        // guard let data = image.pngData() else { return nil }
        let sphere = MeshResource.generatePlane(width: 0.5, height: 0.5)
        var material = SimpleMaterial()
        
        let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        if let data = image.pngData() {
            let filePath = documentsDirectory.appendingPathComponent("\(name).png")
            try? data.write(to: filePath)
            material.color = .init(tint: .white.withAlphaComponent(0.999), texture: .init(try! TextureResource.load(contentsOf: filePath)))
        }
        material.metallic = 1.0
        material.roughness = 0.0
        
        return ModelEntity(mesh: sphere, materials: [material])
    }
}
