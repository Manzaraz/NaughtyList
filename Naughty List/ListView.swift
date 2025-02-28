//
//  ListView.swift
//  Naughty List
//
//  Created by Christian Manzaraz on 20/02/2025.
//

import SwiftUI
import SwiftData
import AVFAudio

struct ListView: View {
    @Query private var children: [Child]
    @State private var sheetIsPresented = false
    @State private var audioPlayer: AVAudioPlayer!
    
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
                    .swipeActions {
                        Button(role: .destructive) {
                            modelContext.delete(child)
                            guard let _ = try? modelContext.save() else {
                                print("🤬ERROR: Save after .delete in ListView did not work.")
                                return
                            }
                        } label: {
                            Label("Delete", systemImage: "trash.fill")
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
        .onAppear {
            playSound(soundName: "riff")
        }
    }
}


#Preview {
    ListView()
        .modelContainer(Child.preview)
}

extension ListView {
    func playSound(soundName: String) {
        guard let soundFile = NSDataAsset(name: soundName) else {
            print("🎶ERROR: Could not read file named \(soundName)")
            return
        }
        do {
            audioPlayer = try AVAudioPlayer(data: soundFile.data)
            audioPlayer.play()
        } catch  {
            print("🎶ERROR: \(error.localizedDescription) creating AVAudioPlayer")
        }
    }
}
