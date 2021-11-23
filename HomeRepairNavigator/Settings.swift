//
//  Settings.swift
//  HomeRepairNavigator
//
//  Created by robevans on 11/16/21.
//

import SwiftUI

struct Settings: View {
    @Environment(\.openURL) var openURL
    @AppStorage("UserDefault_FirstRun") var showFirstRun = true
    @AppStorage("UserDefault_ShowTerms") var showTerms = true

    @AppStorage("UserDefault_CompleteTasks") var useCompletedTasks = false
    @State var showWelcomeScreen = false
    @State var agreement = false
    @State var showProject = false

    var body: some View {
        ZStack {
            Color("Background")
                .edgesIgnoringSafeArea(.all)
            NavigationView {
                VStack {
                    Form {
                        Section(header: Text("")) {
                        Button(action: {
                            showWelcomeScreen = true
                        }) {
                            IconView(image: "hand.wave", color: "SettingColor3", text: "Welcome Info")
                        }
                        .buttonStyle(PlainButtonStyle())
                        Button(action: {
                            agreement = true
                        }) {
                            IconView(image: "book", color: "SettingColor2", text: "Terms")
                        }
                        .buttonStyle(PlainButtonStyle())
                            Button(action: {
                                showProject = true
                            }) {
                                IconView(image: "rectangle.and.pencil.and.ellipsis", color: "SettingColor3", text: "Project Info")
                            }
                            .buttonStyle(PlainButtonStyle())
                        Button(action: {
                            openURL(URL(string: "https://www.paypal.com/fundraiser/charity/1381672")!)
                        }) {
                            IconView(image: "gift", color: "SettingColor1", text: "Donate")
                        }
                        .buttonStyle(PlainButtonStyle())
                        Button(action: {
                            let mailtoString = "mailto:info@naahrf.org?subject=Home Repair Navigator Feedback ".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
                            let mailtoUrl = URL(string: mailtoString!)!
                            if UIApplication.shared.canOpenURL(mailtoUrl) {
                                    UIApplication.shared.open(mailtoUrl, options: [:])
                            }
                        }) {
                            IconView(image: "mail", color: "SettingColor2", text: "Contact")
                        }
                        .buttonStyle(PlainButtonStyle())
                        Button(action: {
                            HomeRepairNavigator.actionSheet()
                        }) {
                            IconView(image: "square.and.arrow.up", color: "SettingColor4", text: "Share Home Repair Navigator")
                        }
                        .buttonStyle(PlainButtonStyle())
                        }
                        Section(header: Text("")) {
                            Button(action: {
                                openURL(URL(string: "https://naahrf.org/")!)
                            }) {
                                IconView(image: "globe", color: "SettingColor1", text: "Website")
                            }
                            .buttonStyle(PlainButtonStyle())
                            Button(action: {
                                showFirstRun = true
                                showTerms = true
                            }) {
                                IconView(image: "exclamationmark.arrow.circlepath", color: "SettingColor3", text: "Reset")
                            }
                            .buttonStyle(PlainButtonStyle())
                            HStack {
                                IconView(image: "phone", color: "SettingColor2", text: "Contact")
                                Link("", destination: URL(string: "tel:4049416832")!)
                            }
                        }
                        HStack {
                            Spacer()
                                Text("Task Completion Style:")
                                .bold()
                            Spacer()
                        }
                        HStack {
                            Spacer()
                            CheckMarkView(checked: .constant(useCompletedTasks ? false : true), trimValue: .constant(1))
                                .onTapGesture {
                                    withAnimation {
                                        playHaptic(style: "medium")
                                        useCompletedTasks = false
                                    }
                                }
                            Spacer()
                            CompletedView(checked: .constant(useCompletedTasks ? true : false), trimValue: .constant(1))
                                .onTapGesture {
                                    withAnimation {
                                        playHaptic(style: "medium")
                                        useCompletedTasks = true
                                    }
                                }
                            Spacer()
                        }
                        Text("Version: \(getAppVersion())")
                    }

                }
                .navigationBarTitle("Settings")
                .sheet(isPresented: $showWelcomeScreen,
                       content: {
                    WelcomeScreen(showWelcomeScreen: $showWelcomeScreen)
                })
                .sheet(isPresented: $agreement,
                       content: {
                    AgreementView(agreement: $agreement)
                })
                .fullScreenCover(isPresented: $showProject, content: {
                    ProjectOnboard(showProject: $showProject)
                })
            }
            .navigationViewStyle(StackNavigationViewStyle())
        }
    }
}

struct Settings_Previews: PreviewProvider {
    static var previews: some View {
        Settings()
        Settings()
            .colorScheme(.dark)
    }
}

func getAppVersion() -> String {
    if let result = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String {
        return result
    } else {
        assert(false)
        return ""
    }
}

func actionSheet() {
       guard let urlShare = URL(string: "url") else { return }
       let activityVC = UIActivityViewController(activityItems: [urlShare], applicationActivities: nil)
       UIApplication.shared.windows.first?.rootViewController?.present(activityVC, animated: true, completion: nil)
   }

