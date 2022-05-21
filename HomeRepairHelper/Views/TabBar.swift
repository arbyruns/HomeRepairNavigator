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
                NotesList(projectData: projectData, showProjectView: $showProjectView).tabItem {
                    Image(systemName: "note.text")
                        .font(.system(size: 24, weight: .semibold))
                    Text("Notes")
                }
                PhotoAlbumView(projectData: projectData, showProjectView: $showProjectView).tabItem {
                    Image(systemName: "photo")
                        .font(.system(size: 24, weight: .semibold))
                    Text("Photo")
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
