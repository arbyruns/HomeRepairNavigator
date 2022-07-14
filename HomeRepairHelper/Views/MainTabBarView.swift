//
//  TabBarView.swift
//  HomeRepairHelper
//
//  Created by robevans on 7/13/22.
//
import SwiftUI

struct MainTabBarView: View {
    @State var currentTab: Tab = .home

    var body: some View {
        TabView(selection: $currentTab) {
            ProjectView()
                .tabItem {
                    Label("home", systemImage: "house")
                }
                .tag(Tab.home)
            LicenseVerificationView()
                .tabItem {
                    Label("Verification", systemImage: "list.dash")
                }
                .tag(Tab.verification)
        }
    }
}

struct MainTabBarView_Previews: PreviewProvider {
    static var previews: some View {
        MainTabBarView()
    }
}

enum Tab: String {
    case home = "home"
    case verification = "verification"
    case settings = "settings"
}
