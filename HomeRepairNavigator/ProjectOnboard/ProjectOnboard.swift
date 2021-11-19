//
//  ProjectOnboard.swift
//  HomeRepairNavigator
//
//  Created by robevans on 11/18/21.
//

import SwiftUI

struct ProjectOnboard: View {
    @State var currentIndex = 0

    var body: some View {
        ZStack {
            Color("Background")
                .edgesIgnoringSafeArea(.all)
            VStack {
                TabView(selection: $currentIndex) {
                    ProfileScreenView()
                        .tag(0)
                    ProjectScreen()
                        .tag(1)
                    BudgetView()
                        .tag(2)
                }
                .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .never))
                .tabViewStyle(PageTabViewStyle())
                Button(action: {
                    withAnimation {
                        if currentIndex != 2 {
                            currentIndex += 1
                        } else {
                            currentIndex = 0
                        }
                    }
                }) {
                    if currentIndex != 2 {
                    ButtonTextView(smallButton: false, text: "Next")
                        .padding()
                    } else {
                        ButtonTextView(smallButton: false, text: "OK")
                            .padding()
                    }
                }
            }
        }
    }
}

struct ProjectOnboard_Previews: PreviewProvider {
    static var previews: some View {
        ProjectOnboard()
        ProjectOnboard()
            .colorScheme(.dark)
    }
}
