//
//  EVAApp.swift
//  EVA
//
//  Created by husayn on 21/07/2024.
//

import SwiftUI

@main
struct EVAApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            SplashScreen()
//            ContentView()
//                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
