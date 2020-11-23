//
//  CoreDataProjectApp.swift
//  CoreDataProject
//
//  Created by Krzysztof Kostrzewa on 23/11/2020.
//

import SwiftUI

@main
struct CoreDataProjectApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
