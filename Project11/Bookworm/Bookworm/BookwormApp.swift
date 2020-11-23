//
//  BookwormApp.swift
//  Bookworm
//
//  Created by Krzysztof Kostrzewa on 21/11/2020.
//

import SwiftUI

@main
struct BookwormApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
