//
//  NotesList.swift
//  HomeRepairHelper
//
//  Created by robevans on 1/14/22.
//

import SwiftUI

struct NotesList: View {
    @AppStorage("UserDefaults_photoAlbumTabBar") var photoAlbumTabBar = false

    @StateObject var coredataVM = CoreDataManager()
    @StateObject var projectData = ProjectData()
    @StateObject var telemtryData = TelemetryData()

    @State var showNotesSheet = false
    @State var showUserNote = false

    @State var userNotes: [String] = []
    @State var userNote = ""
    @State var showEmptyState = false

    @Binding var showProjectView: Bool
    @Binding var showNotesView: Bool

    var body: some View {
        NavigationView {
            ZStack {
                Color("Background")
                    .edgesIgnoringSafeArea(.all)
                VStack {
                    switch showEmptyState {
                    case true:
                        Text("Empty View")
                    default:
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
                                        entity.notes?.remove(at: indexSet.first!)
                                        coredataVM.saveData()

                                    }
                                }
                            })
                            .listRowBackground(Color.clear)
                        }
                        .onChange(of: showNotesSheet) { newValue in
                                coredataVM.fetchData()
                        }
                    }
                }
                .sheet(isPresented: $showUserNote) {
                    NotesView(projectData: projectData, userNote: $userNote, showNotesSheet: $showNotesSheet, showUserNote: $showUserNote)
                }
                .sheet(isPresented: $showNotesSheet,
                                 onDismiss: {
                    showEmptyState = false
                    coredataVM.savedEntities = []
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                        coredataVM.fetchData()
                    }
                },
                                 content: {
                    NotesView(projectData: projectData, userNote: $userNote, showNotesSheet: $showNotesSheet, showUserNote: $showUserNote) })
                .onAppear {
                    UITableView.appearance().backgroundColor = .clear
                }
                .navigationBarTitle("Project Notes")
                .toolbar {
                    ToolbarItem(placement: .primaryAction) {
                        Button(action: {
                            playHaptic(style: "medium")
                            showNotesSheet = true
                            coredataVM.savedEntities = []
                            telemtryData.sendScreen(screen: "NewNoteTapped")
                        }) {
                            Image(systemName: "plus.square")
                        }
                    }
                    ToolbarItem(placement: .cancellationAction) {
                        Button(action: {
                            playHaptic(style: "medium")
                            if !photoAlbumTabBar {
                                showProjectView = false
                            }
                            showNotesView = false
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
        NotesList(showProjectView: .constant(false), showNotesView: .constant(false))
    }
}
