//
//  AnimatedGradient.swift
//  ReVision
//
//  Created by Rahul Narayanan on 10/14/23.
//

import SwiftUI

struct AnimatedGradient: View {
    @State var gradient = [Color.red, Color.purple, Color.orange]
        @State var startPoint = UnitPoint(x: 0, y: 0)
        @State var endPoint = UnitPoint(x: 0, y: 2)
        
        var body: some View {
            RoundedRectangle(cornerRadius: 8)
                .fill(LinearGradient(gradient: Gradient(colors: self.gradient), startPoint: self.startPoint, endPoint: self.endPoint))
                .onAppear {
                    withAnimation (.easeInOut(duration: 3)){
                        self.startPoint = UnitPoint(x: 1, y: -1)
                        self.endPoint = UnitPoint(x: 0, y: 1)
                    }
            }
        }
}
