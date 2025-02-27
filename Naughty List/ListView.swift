//
//  ListView.swift
//  Naughty List
//
//  Created by Christian Manzaraz on 20/02/2025.
//

import SwiftUI
import SwiftData


struct ListView: View {
    @Query private var children: [Child]
    

    
    var body: some View {
        NavigationStack {
            List {
                ForEach(children) { child in
                    HStack {
                        Image(child.naughty ? "naughty" : "nice")
                            .resizable()
                            .scaledToFit()
                            .frame(height: 30)
                        
                        Text("\(child.firstName) \(child.lastName)")
                            .font(.title2)
                    }
                }
            }
            .listStyle(.plain)
            .navigationTitle("Schmutzli's List")
        }
        .padding()
    }
}


#Preview {
    ListView()
        .modelContainer(Child.preview)
}
