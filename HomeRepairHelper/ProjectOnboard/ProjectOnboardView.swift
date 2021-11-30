//
//  ProjectOnboard.swift
//  HomeRepairNavigator
//
//  Created by robevans on 11/18/21.
//

import SwiftUI

struct ProjectOnboardView: View {
    @StateObject var telemtryData = TelemetryData()

    @State var zipCode = ""
    @State var userProject = ""
    @State var userBudget = ""
    @State var showProjectHelp = false
    @State var currentIndex = 0
    @State var showConfirmation = false

    @Binding var showProject: Bool
    

    var body: some View {
        ZStack {
            Color("Background")
                .edgesIgnoringSafeArea(.all)
            VStack {
                TabView(selection: $currentIndex) {
                    ProfileScreenView(zipCode: $zipCode)
                        .tag(0)
                    ProjectTypeView(userProject: $userProject)
                        .tag(1)
                    BudgetView(userBudget: $userBudget)
                        .tag(2)
                }
                .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .never))
                .tabViewStyle(PageTabViewStyle())
                Button(action: {
                    withAnimation {
                        if currentIndex != 2 {
                            playHaptic(style: "light")
                            currentIndex += 1
                        } else {
                            withAnimation {
                            playHaptic(style: "medium")
                            showConfirmation = true
                            }
                        }
                    }
                }) {
                        ButtonTextView(smallButton: false, text: buttonText(index: currentIndex))
                        .padding()
                        .opacity(showConfirmation ? 0 : 1)
                }
                Button(action: {
                    showProject = false
                    playHaptic(style: "heavy")
                }) {
                    SecondaryButtonTextView(smallButton: false, text: "Cancel")
                        .padding(.bottom)
                        .opacity(showConfirmation ? 0 : 1)
                }
            }
            if showConfirmation {
                ConfirmationScreen(showProject: $showProject,
                                   showConfirmation: $showConfirmation,
                                   zipCode: $zipCode,
                                   userProject: $userProject, userBudget: $userBudget)
            }
        }
        .sheet(isPresented: $showProjectHelp,
               content: {
            About(showProjectHelp: $showProjectHelp)
                .animation(.easeInOut)
                .transition(.opacity)
        })
    }
}

struct ProjectOnboard_Previews: PreviewProvider {
    static var previews: some View {
        ProjectOnboardView(showProject: .constant(false))
        ProjectOnboardView(showProject: .constant(false))
            .colorScheme(.dark)
    }
}

func verifyZip(zip: String) -> Bool {
    if zip.count != 5 {
        return true
    } else {
        return false
    }
}

func buttonText(index: Int) -> String {
    if index != 2 {
        return "Next"
    } else {
        return "OK"
    }
}
