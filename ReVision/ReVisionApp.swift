//
//  ReVisionApp.swift
//  ReVision
//
//  Created by Rahul Narayanan on 10/13/23.
//

import SwiftUI

@main
struct ReVisionApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
