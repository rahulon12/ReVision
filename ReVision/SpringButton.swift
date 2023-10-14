//
//  SpringButton.swift
//  ReVision
//
//  Created by Rahul Narayanan on 10/14/23.
//

import SwiftUI

struct SpringButton: ButtonStyle {
    @State private var scaleOffset: CGFloat = 1
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .scaleEffect(scaleOffset)
            .animation(.spring, value: scaleOffset)
            .onChange(of: configuration.isPressed) { newValue in
                if newValue { scaleOffset = 0.8 }
                else { scaleOffset = 1 }
            }
    }
    
    
}
