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
    @State var showEmptyState = true

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
                        Group {
                            HStack {
                                Text("Tap ")
                                Image(systemName: "plus.square")
                                Text("To Add a Note")
                            }
                        }
                        .font(.title3)
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
                    coredataVM.savedEntities = []
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                        coredataVM.fetchData()
                        for entity in coredataVM.savedEntities {
                            if entity.projectName == projectData.projectName {
                                if entity.notes?.count ?? 0 > 0 {
                                    showEmptyState = false
                                }
                            }
                        }
                    }
                },
                                 content: {
                    NotesView(projectData: projectData, userNote: $userNote, showNotesSheet: $showNotesSheet, showUserNote: $showUserNote) })
                .onAppear {
                    UITableView.appearance().backgroundColor = .clear
                    for entity in coredataVM.savedEntities {
                        if entity.projectName == projectData.projectName {
                            if entity.notes?.count ?? 0 > 0 {
                                showEmptyState = false
                            }
                        }
                    }
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
