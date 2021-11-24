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
    @AppStorage("UserDefault_ShowTerms") var showTerms = true
    @AppStorage("UserDefault_showTutorial") var showTutorial = true

    var body: some View {
        VStack {
            TabView {
                BeforeProject(infoOverLayInfo: OverLayInfo(), showButtons: .constant(false), completed: .constant(false)).tabItem {
                    Image(systemName: "arrow.clockwise")
                        .font(.system(size: 24, weight: .semibold))
                    Text("Before Project")
                }
                DuringProject(infoOverLayInfo: OverLayInfo(), showButtons: .constant(false), completed: .constant(false)).tabItem {
                    Image(systemName: "arrow.triangle.2.circlepath")
                        .font(.system(size: 24, weight: .semibold))
                    Text("During Project")
                }
                AfterProject(infoOverLayInfo: OverLayInfo(), showButtons: .constant(false), completed: .constant(false)).tabItem {
                    Image(systemName: "arrow.counterclockwise")
                        .font(.system(size: 24, weight: .semibold))
                    Text("After Project")
                }
                Settings().tabItem {
                    Image(systemName: "gear")
                        .font(.system(size: 24, weight: .semibold))
                    Text("Settings")

                }
            }
            .fullScreenCover(isPresented: $showTutorial,
                onDismiss: { print("dismissed!") },
                             content: { TutorialView() })
        }
    }
}

struct TabBar_Previews: PreviewProvider {
    static var previews: some View {
        TabBar()
        TabBar()
            .colorScheme(.dark)
    }
}
