//
//  NotesView.swift
//  HomeRepairHelper
//
//  Created by robevans on 1/14/22.
//

import SwiftUI

struct NotesView: View {
    @StateObject var coredataVM = CoreDataManager()
    @StateObject var projectData = ProjectData()
    @StateObject var telemtryData = TelemetryData()

    @State var textEditor  = "Tap to add a note..."

    @Binding var userNote: String
    @Binding var showNotesSheet: Bool
    @Binding var showUserNote: Bool

    var body: some View {
        NavigationView {
            ZStack {
                Color("Background")
                    .edgesIgnoringSafeArea(.all)
                VStack {
                    Divider()
                        .padding()
                    if !showUserNote {
                    GeometryReader { geo in
                        VStack {
                            TextEditor(text: $textEditor)
                                .frame(width: geo.size.width - 30, height: geo.size.height / 2, alignment: .center)
                                .cornerRadius(13)
                                .padding()
                                .onTapGesture {
                                    playHaptic(style: "light")
                                }
                        }
                    }
                    Button(action: {
                        print("save button tapped: Project - \(projectData.projectName)")
                        playHaptic(style: "medium")
                        for entity in coredataVM.savedEntities {
                            if entity.projectName == projectData.projectName {
                                print("saving notes \(textEditor)")
                                coredataVM.saveUserNotes(entity, textEditor)
                            }
                        }
                        coredataVM.savedEntities = []
                        coredataVM.fetchData()
                        
                        telemtryData.sendScreen(screen: "User Saved Note")
                        showNotesSheet = false
                    }) {
                        ButtonTextView(smallButton: false, text: "Save")
                            .padding()
                    }
                    Button(action: {
                        playHaptic(style: "medium")
                        showNotesSheet = false
                        telemtryData.sendScreen(screen: "User Note canceled")
                    }) {
                        ButtonTextView(smallButton: true, text: "Cancel")
                            .padding(.horizontal, 45)
                    }
                    } else {
                        Text(userNote)
                            .font(.subheadline)
                        Spacer()
                    }
                }
            }
            .navigationBarTitle(showUserNote ? "Notes" : "New Note:")
        }
    }
}

struct NotesView_Previews: PreviewProvider {
    static var previews: some View {
        NotesView(userNote: .constant("Some Notes"), showNotesSheet: .constant(false), showUserNote: .constant(false))
        NotesView(userNote: .constant("Some Notes"), showNotesSheet: .constant(false), showUserNote: .constant(false))
            .colorScheme(.dark)
    }
}
