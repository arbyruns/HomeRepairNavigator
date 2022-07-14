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
            LicenseVerificationView(selectedItem: .init(id: 3, state: "South Carolina", stateURL: "https://verify.llronline.com/LicLookup/LookupMain.aspx", stateCode: "south-carolina"))
                .tabItem {
                    Label("Verification", systemImage: "checkmark.seal")
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
