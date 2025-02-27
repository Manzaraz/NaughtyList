//
//  Child.swift
//  Naughty List
//
//  Created by Christian Manzaraz on 27/02/2025.
//

import Foundation
import SwiftData


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
