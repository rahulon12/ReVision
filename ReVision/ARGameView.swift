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

class ViewController: UIViewController, ARSessionDelegate {
    
    private var arView: ARView!
    
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
            let anchor = ARAnchor(transform: firstResult.worldTransform)
            arView.session.add(anchor: anchor)
            
            
            print("Successfully added anchor")
        }
    }
    
    func session(_ session: ARSession, didAdd anchors: [ARAnchor]) {
        for anchor in anchors {
            if let name = anchor.name {
                let imageAnchor = createImage(name)
                
                let stroke = AnchorEntity(anchor: anchor)
                stroke.addChild(imageAnchor)
                arView.scene.addAnchor(stroke)
            }
        }
    }
    
    private func createImage(_ image: String) -> ModelEntity {
        let sphere = MeshResource.generatePlane(width: 0.1, height: 0.1)
        var material = SimpleMaterial()
        material.color = .init(tint: .white.withAlphaComponent(0.999), texture: .init(try! .load(named: image)))
        material.metallic = 1.0
        material.roughness = 0.0
        
        return ModelEntity(mesh: sphere, materials: [material])
    }
}
