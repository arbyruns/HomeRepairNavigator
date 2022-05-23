//
//  TabBar.swift
//  HomeRepairNavigator
//
//  Created by robevans on 11/16/21.
//

import SwiftUI
import TelemetryClient

struct TabBar: View {
    @AppStorage("UserDefault_FirstRun") var showFirstRun = true
    @AppStorage("UserDefaults_photoAlbumTabBar") var photoAlbumTabBar = false

    @ObservedObject var projectData: ProjectData

    @Binding var showProjectView: Bool

    var body: some View {
        VStack {
            TabView {
                BeforeProject(infoOverLayInfo: OverLayInfo(), projectData: projectData, showButtons: .constant(false), completed: .constant(false), showProjectView: $showProjectView).tabItem {
                    Image(systemName: "arrow.clockwise")
                        .font(.system(size: 24, weight: .semibold))
                    Text("Before Project")
                }
                DuringProject(infoOverLayInfo: OverLayInfo(), projectData: projectData, showButtons: .constant(false), completed: .constant(false), showProjectView: $showProjectView).tabItem {
                    Image(systemName: "arrow.triangle.2.circlepath")
                        .font(.system(size: 24, weight: .semibold))
                    Text("During Project")
                }
                AfterProject(infoOverLayInfo: OverLayInfo(), projectData: projectData, showButtons: .constant(false), completed: .constant(false), showProjectView: $showProjectView).tabItem {
                    Image(systemName: "arrow.counterclockwise")
                        .font(.system(size: 24, weight: .semibold))
                    Text("After Project")
                }
                if photoAlbumTabBar {
                    PhotoAlbumView(projectData: projectData, showPhotoAlbumView: .constant(false)).tabItem {
                    Image(systemName: "photo")
                        .font(.system(size: 24, weight: .semibold))
                    Text("Photo")
                }
                } else {
                    NotesList(projectData: projectData, showProjectView: $showProjectView, showNotesView: .constant(false)).tabItem {
                        Image(systemName: "note.text")
                            .font(.system(size: 24, weight: .semibold))
                        Text("Notes")
                    }
                }
            }
        }
    }
}

struct TabBar_Previews: PreviewProvider {
    static var previews: some View {
        TabBar(projectData: ProjectData(), showProjectView: .constant(false))
        TabBar(projectData: ProjectData(), showProjectView: .constant(false))
            .colorScheme(.dark)
    }
}
