//
//  Child.swift
//  Naughty List
//
//  Created by Christian Manzaraz on 27/02/2025.
//

import Foundation
import SwiftData

@MainActor
@Model
class Child {
    var firstName = ""
    var lastName = ""
    var naughty = true
    var smacks: Int =  1
    var notes = ""
    
    init(
        firstName: String = "",
        lastName: String = "",
        naughty: Bool = true,
        smacks: Int = 1,
        notes: String = ""
    ) {
        self.firstName = firstName
        self.lastName = lastName
        self.naughty = naughty
        self.smacks = smacks
        self.notes = notes
    }
    
    
}

extension Child {
    static var preview: ModelContainer {
        let container = try! ModelContainer(for: Child.self, configurations: ModelConfiguration(isStoredInMemoryOnly: true))
        
        // Add Mock Data
        var children: [Child] = [
            Child(
                firstName: "Bad",
                lastName: "Bunny",
                naughty: true,
                smacks: 1,
                notes: "Conejo Malo"
            ),
            Child(
                firstName: "Draco",
                lastName: "Malfoy",
                naughty: true,
                smacks: 5,
                notes: "Watch out for wands"
            ),
            Child(
                firstName: "Lisa",
                lastName: "Simpson",
                naughty: false,
                smacks: 0,
                notes: "Always tries her best"
            ),
            Child(
                firstName: "Veruca",
                lastName: "Salt",
                naughty: true,
                smacks: 3,
                notes: "Keep away from candy"
            ),
            Child(
                firstName: "Fred",
                lastName: "Rogers",
                naughty: false,
                smacks: 0,
                notes: "Everyone's favorite neighbor"
            )
        ]
            
        children.forEach { container.mainContext.insert($0) }
        
        return container
    }
}
