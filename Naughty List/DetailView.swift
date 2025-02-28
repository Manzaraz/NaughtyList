//
//  DetailView.swift
//  Naughty List
//
//  Created by Christian Manzaraz on 27/02/2025.
//

import SwiftUI
import SwiftData
import AVFAudio

struct DetailView: View {
    @State var child: Child
    @State private var firstName = ""
    @State private var lastName = ""
    @State private var naughty = true
    @State private var smacks: Int =  1
    @State private var notes = ""
    @State private var audioPlayer: AVAudioPlayer!
    @State private var animateBoy = true
    @State private var animateGirl = true
    
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
                    .scaleEffect(animateBoy ? 1.0 : 0.9) // Scale down as part of withAnimation
                    .onTapGesture {
                        playSound(soundName: "smack")
                        animateBoy = false // Will immediately shrink to 90% using scaleEffect ternary, above
                        withAnimation(.spring(response: 0.3, dampingFraction: 0.3)) {
                            animateBoy = true // will go from 90%% sizer to 100% size but using the spring animation over 0.3 seconds
                        }
                    }
                
                Image(.girl)
                    .resizable()
                    .scaledToFit()
                    .frame(height: 250)
                    .scaleEffect(animateGirl ? 1.0 : 0.9)
                    .onTapGesture {
                        playSound(soundName: "smack")
                        animateGirl = false
                        withAnimation(.spring(response: 0.3, dampingFraction: 0.3)) {
                            animateGirl = true
                        }
                    }
            }
        }
        .navigationBarBackButtonHidden()
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Button("Cancel") {
                    dismiss()
                }
            }
            ToolbarItem(placement: .topBarTrailing) {
                Button("Save") {
                    // move data from UI variables to the child that was passed in
                    child.firstName = firstName
                    child.lastName = lastName
                    child.naughty = naughty
                    child.smacks = smacks
                    child.notes = notes
                    
                    modelContext.insert(child)
                    
                    // Force a seve so you can cgheck this with db browser app
                    guard let _ = try? modelContext.save() else {
                        print("😡ERROR: Save on DetailView did not work")
                        return
                    }
                    
                    dismiss()
                }
            }
        }
        .font(.title2)
        .padding()
        .onAppear {
            // Could also do this in an init, but we've learned onAppear
            firstName = child.firstName
            lastName = child.lastName
            naughty = child.naughty
            smacks = child.smacks
            notes = child.notes
        }
        
    }
    
    func playSound(soundName: String) {
        guard let soundFile = NSDataAsset(name: soundName) else {
            print("😡ERROR: Could not read file named d\(soundName)")
            return
        }
        
        do {
            audioPlayer = try AVAudioPlayer(data: soundFile.data)
            audioPlayer.play()
        } catch {
            print("😡ERROR: \(error.localizedDescription) creating AVAudioPlayer")
        }
    }
}

#Preview {
    DetailView(child: Child())
        .modelContainer(for: Child.self, inMemory: true)
}
