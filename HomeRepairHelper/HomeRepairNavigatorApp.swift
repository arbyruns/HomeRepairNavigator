//
//  HomeRepairNavigatorApp.swift
//  HomeRepairNavigator
//
//  Created by robevans on 11/15/21.
//

import SwiftUI
import TelemetryClient

@main
struct HomeRepairNavigatorApp: App {
    let persistenceController = CoreDataManager()

    var body: some Scene {
        WindowGroup {
            MainTabBarView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
//            ProjectView(projectData: ProjectData())
//                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
    init() {
        // Note: Do not add this code to `WindowGroup.onAppear`, which will be called
        //       *after* your window has been initialized, and might lead to our initialization
        //       occurring too late.
        let configuration = TelemetryManagerConfiguration(appID: "F04097E4-3ECD-42D8-A343-92F46D03EEC9")
        TelemetryManager.initialize(with: configuration)
    }
}

//class AppDelegate: UIResponder, UIApplicationDelegate {
//    let telemetryData = TelemetryData()
//
//    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
//
//        let configuration = TelemetryManagerConfiguration(appID: "F04097E4-3ECD-42D8-A343-92F46D03EEC9")
//        TelemetryManager.initialize(with: configuration)
//        telemetryData.sendLaunchTelemtry()
//
//        return true
//    }
//
//}


