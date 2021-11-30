//
//  ProjectOnboard.swift
//  HomeRepairNavigator
//
//  Created by robevans on 11/18/21.
//

import SwiftUI

struct ProjectOnboardView: View {
    @AppStorage("UserDefault_FirstRun") var showFirstRun = true
    @StateObject var telemtryData = TelemetryData()

    @State var zipCode = ""
    @State var userProject = ""
    @State var userBudget = ""
    @State var showProjectHelp = false
    @State var currentIndex = 0
    @State var showConfirmation = false
    @Binding var showProjectSheet: Bool

    // Tutorial States
    @State var counter = 0
    @State var tutorialOne = false
    @State var tutorialTwo = false
    @State var tutorialThree = false
    @State var scale = false
    @State var disableButton = false

    var body: some View {
        ZStack {
            Color("Background")
                .edgesIgnoringSafeArea(.all)
            VStack {
                TabView(selection: $currentIndex) {
                    WelcomeScreen()
                        .tag(0)
                    AgreementView()
                        .tag(1)
                    TutorialView(tutorialOne: $tutorialOne, tutorialTwo: $tutorialTwo, tutorialThree: $tutorialThree, scale: $scale)
                        .tag(2)
                    ProfileScreenView(zipCode: $zipCode)
                        .tag(3)
                    ProjectTypeView(userProject: $userProject)
                        .tag(4)
                    BudgetView(userBudget: $userBudget)
                        .tag(5)
                }
                .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .never))
                .tabViewStyle(PageTabViewStyle())
                Button(action: {
                    withAnimation {
                        if currentIndex != 5 {
                            playHaptic(style: "light")
                            if currentIndex == 2 {
                                // show first tutorial
                                tutorialOne = true
                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.6) {
                                    withAnimation {
                                        tutorialTwo = true
                                        scale = true
                                        disableButton = true
                                    }
                                }
                                DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                                    withAnimation {
                                        scale = false
                                        tutorialTwo = false
                                        tutorialThree = true
                                    }
                                }
                                DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
                                    withAnimation {
                                        currentIndex += 1
                                        disableButton = false
                                    }
                                }
                            } else if currentIndex == 4 {
                                currentIndex += 1
                            } else {
                                currentIndex += 1
                            }
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
                .disabled(disableButton)
            }
            if showConfirmation {
                ConfirmationScreen(showConfirmation: $showConfirmation,
                                   zipCode: $zipCode,
                                   userProject: $userProject, userBudget: $userBudget)
            }
        }
        .onAppear{
            // This is to determine if the view has been called from settings or the navbar icons
            if showProjectSheet {
                currentIndex = 3
            }
        }

        .sheet(isPresented: $showProjectHelp,
               content: {
            AboutView(showProjectHelp: $showProjectHelp)
                .animation(.easeInOut)
                .transition(.opacity)
        })
    }
}

struct ProjectOnboard_Previews: PreviewProvider {
    static var previews: some View {
        ProjectOnboardView(showProjectSheet: .constant(false))
        ProjectOnboardView(showProjectSheet: .constant(false))
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
    if index != 5 {
        return "Next"
    } else {
        return "OK"
    }
}
