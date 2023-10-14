//
//  ContentView.swift
//  ReVision
//
//  Created by Rahul Narayanan on 10/13/23.
//

import SwiftUI
import CoreData

struct ContentView: View {
    var body: some View {
        NavigationView {
            ZStack {
                Color("Background")
                    .edgesIgnoringSafeArea(.all)
                VStack {
                    Image("Logo")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 300)
                    NavigationLink(destination: PhotosSelector()) {
                        Text("Play Game")
                            .frame(width: 300, height:60)
                            .background(Color.black)
                            .foregroundColor(Color.white)
                            .cornerRadius(10)
                            .bold()
                    }
                }
            }
        }
//        PhotosSelector()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
