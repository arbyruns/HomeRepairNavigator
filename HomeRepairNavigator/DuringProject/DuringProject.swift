//
//  DuringProject.swift
//  HomeRepairNavigator
//
//  Created by robevans on 11/16/21.
//

import SwiftUI
import SwiftUINavigationBarStyling

struct DuringProject: View {
    @Environment(\.colorScheme) var colorScheme
    @ObservedObject var infoOverLayInfo: OverLayInfo

    @State var showInfo = false
    @Binding var showButtons: Bool
    @Binding var completed: Bool

    var body: some View {
            ZStack {
                NavigationView {
                VStack {
                    ScrollView {
                        VStack(spacing: 20) {
                            ForEach(duringProjectData) { data in
                                ProjectRowView(infoOverLayInfo: infoOverLayInfo,
                                               showInfo: $showInfo,
                                               title: data.title,
                                               question: data.title,
                                               info: data.description,
                                               completedID: data.trackingID)
                                    .disabled(showInfo ? true : false)
                            }
                        }
                        .padding(.top)
                    }
                }
                .background(Color("Background"))
                .sheet(isPresented: $showInfo,
                       onDismiss:  { self.showButtons = false },
                       content: {
                    InfoSheet(infoOverlay: infoOverLayInfo, showInfo: $showInfo)
                })
                .navigationTitle("During Project")
                .navigationBarColor(colorScheme == .dark ? UIColor(Color("borderColor")) : UIColor(Color("buttonColorRed")), textColor: UIColor(Color("FontColor")))
            }
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

struct DuringProject_Previews: PreviewProvider {
    static var previews: some View {
        DuringProject(infoOverLayInfo: OverLayInfo(), showButtons: .constant(false), completed: .constant(false))
        DuringProject(infoOverLayInfo: OverLayInfo(), showButtons: .constant(false), completed: .constant(false))
            .colorScheme(.dark)
    }
}

struct DuringProjectData: Identifiable {
    var id = UUID()
    var trackingID: Int
    var title: String
    var description: String
}

var duringProjectData = [
    BeforeProjectData(trackingID: 17, title: "Have you taken pictures before any work begins?", description: "We suggest you take pictures before, during and after the project. We suggest you take pictures before, during and after the project."),
    BeforeProjectData(trackingID: 18, title: "Have you secured your valuables?", description: "We suggest you secure your valuables including any papers you have lying around with your personal information on it."),
    BeforeProjectData(trackingID: 19, title: "Do you have copies of all permits?", description: "We suggest you keep copies of all permits.  The contractor should give you copies.  You can also get copies from your local building & zoning department."),
    BeforeProjectData(trackingID: 20, title: "Have you started a daily progress journal?", description: "Be sure to include things like the weather, who was on site on what day/time, what work was done, who showed up late, etc.  We suggest you keep a daily log of the project.  Include things like the weather, who was on site on what day/time, what work was done, who showed up late, etc."),
    BeforeProjectData(trackingID: 21, title: "Are you taking pictures throughout the project?", description: "We suggest you take pictures before, during and after the project. We suggest you take pictures before, during and after the project."),
    BeforeProjectData(trackingID: 22, title: "Are you getting regular updates of the progress from the contractor?", description: "We suggest you communicate regularly with the contractor, so he can keep you up to date on the progress of the project."),
    BeforeProjectData(trackingID: 23, title: "Are you getting all change orders in writing?", description: "We suggest that you get all change orders in writing and add them to the contract.  If you are not sure about something, you can contact your attorney to make sure any change orders become part of the contract.")
]
