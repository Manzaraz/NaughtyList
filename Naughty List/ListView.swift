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
    @State private var sheetIsPresented = false
    @Environment(\.modelContext) private var modelContext
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(children) { child in
                    NavigationLink {
                        DetailView(child: child)
                    } label: {
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
            }
            .listStyle(.plain)
            .navigationTitle("Schmutzli's List")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        sheetIsPresented.toggle()
                    } label: {
                        Image(systemName: "plus")
                    }
                    
                }
            }
        }
        .sheet(isPresented: $sheetIsPresented) {
            NavigationStack{
                DetailView(child: Child())
            }
        }
    }
}


#Preview {
    ListView()
        .modelContainer(Child.preview)
}
