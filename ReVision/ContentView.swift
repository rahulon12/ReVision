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
//                    Button {
//                        modes()
//                    } label: {
//                        Image("Logo")
//                    }
//                    .foregroundColor(.black)
                    NavigationLink(destination: ModeView()) {
                        Text("Play")
                            .frame(width: 300, height:60)
                            .background(Color.gray)
                            .foregroundColor(Color.black)
                            .cornerRadius(10)
                    }
                }
            }
        }
    }
    
    func modes() {
        print("choosing modes")
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
