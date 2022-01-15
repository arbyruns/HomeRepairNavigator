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
                        .onDelete(perform: { indexSet in
                            for entity in coredataVM.savedEntities {
                                if projectData.projectName == entity.projectName {
                                    print(indexSet.first)
                                    entity.notes?.remove(at: indexSet.first!)
                                    coredataVM.saveData()

                                }
                            }
                        }

                        )
                    }
                    .onChange(of: showNotesSheet) { newValue in
                            coredataVM.fetchData()
                    }
                    .sheet(isPresented: $showUserNote) {
                        NotesView(projectData: projectData, userNote: $userNote, showNotesSheet: $showNotesSheet, showUserNote: $showUserNote)
                    }
                    .fullScreenCover(isPresented: $showNotesSheet,
                                     onDismiss: {
                        coredataVM.fetchData()
                    },
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
