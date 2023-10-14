//
//  ModeView.swift
//  ReVision
//
//  Created by Stanley Wong on 10/13/23.
//

import SwiftUI

struct ModeView: View {
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
        NavigationView {
            NavigationLink(destination: SinglePlayerView()) {
                Text("Single Player")
                    .frame(width: 300, height:60)
                    .background(Color.gray)
                    .foregroundColor(Color.black)
                    .cornerRadius(10)
            }
        }
    }
}

struct ModeView_Previews: PreviewProvider {
    static var previews: some View {
        ModeView()
    }
}
