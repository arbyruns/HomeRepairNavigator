//
//  NotesList.swift
//  HomeRepairHelper
//
//  Created by robevans on 1/14/22.
//

import SwiftUI

struct NotesList: View {
    @StateObject var coredataVM = CoreDataManager()
    @StateObject var projectData = ProjectData()
    @State var showNotesSheet = false
    @State var showUserNote = false

    @State var userNotes: [String] = []
    @State var userNote = ""

    @Binding var showProjectView: Bool

    var body: some View {
            ZStack {
                Color("Background")
                    .edgesIgnoringSafeArea(.all)
                NavigationView {
                VStack {
                    List {
                        ForEach(coredataVM.savedEntities) { entity in
                            if entity.projectName == projectData.projectName {
                                ForEach(entity.notes ?? [""], id: \.self) { note in
                                    Text(note)
                                        .onTapGesture{
                                            showUserNote = true
                                            userNote = note
                                        }
                                }
                            }
                        }
                    }
                    .onChange(of: showNotesSheet) { newValue in
                        for entity in coredataVM.savedEntities {
                            if entity.projectName == projectData.projectName {
                                userNotes = coredataVM.getUserNotes(entity, projectData.projectName)
                            }
                        }
                    }
                    .sheet(isPresented: $showUserNote) {
                        NotesView(projectData: projectData, userNote: $userNote, showNotesSheet: $showNotesSheet, showUserNote: $showUserNote)
                    }
                    .fullScreenCover(isPresented: $showNotesSheet,
                                     onDismiss: {},
                                     content: {
                        NotesView(projectData: projectData, userNote: $userNote, showNotesSheet: $showNotesSheet, showUserNote: $showUserNote) })
                }
                .navigationBarTitle("Project Notes")
                .toolbar {
                    ToolbarItem(placement: .primaryAction) {
                        Button(action: {
                            playHaptic(style: "medium")
                            showNotesSheet = true
                        }) {
                            Image(systemName: "plus.square")
                        }
                    }
                    ToolbarItem(placement: .cancellationAction) {
                        Button(action: {
                            playHaptic(style: "medium")
                            showProjectView = false
                        }) {
                            Image(systemName: "xmark.circle")
                        }
                    }
                }
            }
        }

    }
}

struct NotesList_Previews: PreviewProvider {
    static var previews: some View {
        NotesList(showProjectView: .constant(false))
    }
}
