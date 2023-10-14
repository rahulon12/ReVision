//
//  PictureAnchor.swift
//  ReVision
//
//  Created by Rahul Narayanan on 10/14/23.
//

import UIKit
import ARKit

class PictureAnchor: ARAnchor {
    var image: UIImage?
    
    override init(name: String, transform: float4x4) {
        super.init(name: name, transform: transform)
    }
    
    required init(anchor: ARAnchor) {
        super.init(anchor: anchor)
    }
    
    required init?(coder aDecoder: NSCoder) {
        if let image = aDecoder.decodeObject(forKey: "image") as? UIImage {
            self.image = image
        } else {
            return nil
        }
        super.init(coder: aDecoder)
    }
    
    override func encode(with aCoder: NSCoder) {
        super.encode(with: aCoder)
        aCoder.encode(image, forKey: "image")
    }
    
    override class var supportsSecureCoding: Bool {
        return true
    }
}
