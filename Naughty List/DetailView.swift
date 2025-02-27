//
//  DetailView.swift
//  Naughty List
//
//  Created by Christian Manzaraz on 27/02/2025.
//

import SwiftUI
import SwiftData

struct DetailView: View {
    @State var child: Child
    @State private var firstName = ""
    @State private var lastName = ""
    @State private var naughty = true
    @State private var smacks: Int =  1
    @State private var notes = ""
    
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("First Name:")
                .bold()
            
            TextField("first", text: $firstName)
                .textFieldStyle(.roundedBorder)
            
            Text("Last Name:")
                .bold()
            
            TextField("last", text: $lastName)
                .textFieldStyle(.roundedBorder)
            
            Toggle("Naughty?", isOn: $naughty)
                .bold()
                .onChange(of: naughty) {
                    smacks = (naughty == true && smacks == 0) ? 1 : smacks
                    smacks = naughty == false ? 0 : smacks
                }
            
            Stepper("Smacks Deserved", value: $smacks, in: 0...5)
                .bold()
                .onChange(of: smacks) {
                    naughty = smacks == 0 ? false : true
                }
            
            Text("\(smacks)")
                .font(.largeTitle)
                .frame(maxWidth: .infinity, alignment: .center)
            
            Text("Notes:")
                .bold()
            
            TextField("notes", text: $notes)
                .textFieldStyle(.roundedBorder)
            
            Spacer()
            
            HStack(alignment: .center ) {
                Image(.boy)
                    .resizable()
                    .scaledToFit()
                    .frame(height: 250)
                
                Image(.girl)
                    .resizable()
                    .scaledToFit()
                    .frame(height: 250)
            }
        }
        .font(.title2)
        .padding()
    }
}

#Preview {
    DetailView(child: Child())
        .modelContainer(for: Child.self, inMemory: true)
}
