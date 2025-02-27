//
//  Naughty_ListApp.swift
//  Naughty List
//
//  Created by Christian Manzaraz on 20/02/2025.
//

import SwiftUI
import SwiftData

@main
struct Naughty_ListApp: App {
    var body: some Scene {
        WindowGroup {
            ListView()
                .modelContainer(for: Child.self)
        }
    }
    
    // Will allow us to find where our simulator data is saved:
    init() {
        print(URL.applicationSupportDirectory.path(percentEncoded: false))
    }
}
