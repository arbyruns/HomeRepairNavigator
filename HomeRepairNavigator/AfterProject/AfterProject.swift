//
//  AfterProject.swift
//  HomeRepairNavigator
//
//  Created by robevans on 11/16/21.
//

import SwiftUI

struct AfterProject: View {
    @Environment(\.colorScheme) var colorScheme
    @ObservedObject var infoOverLayInfo: OverLayInfo

    @State var showInfo = false
    @Binding var showButtons: Bool
    @Binding var completed: Bool

    var body: some View {
        ZStack {
            Color("Background")
                .edgesIgnoringSafeArea(.all)
            VStack {
                Text("After Project")
                    .bold()
                    .foregroundColor(Color("FontColor"))
                    .textCase(.uppercase)
                    .font(.largeTitle)
                ScrollView {
                    VStack(spacing: 20) {
                        ForEach(afterProjectData) { data in
                            ProjectRowView(infoOverLayInfo: infoOverLayInfo,
                                           showInfo: $showInfo,
                                           title: data.title,
                                           question: data.title,
                                           info: data.description,
                                           completedID: 1)
                                .disabled(showInfo ? true : false)
                        }
                    }
                }
            }
            .sheet(isPresented: $showInfo,
                   onDismiss:  { self.showButtons = false },
                   content: {
                InfoSheet(infoOverlay: infoOverLayInfo, showInfo: $showInfo)
            })
        }
    }
}

struct AfterProject_Previews: PreviewProvider {
    static var previews: some View {
        AfterProject(infoOverLayInfo: OverLayInfo(), showButtons: .constant(false), completed: .constant(false))
        AfterProject(infoOverLayInfo: OverLayInfo(), showButtons: .constant(false), completed: .constant(false))
            .colorScheme(.dark)
    }
}

struct AfterProjectData: Identifiable {
    var id = UUID()
    var title: String
    var description: String
}

var afterProjectData = [
    AfterProjectData(title: "Has the project been completed?", description: "It is a good idea to inspect the project to make sure it is done to your liking.  If you are unsure about something, you might consider hiring an inspector to verify that the job has been done correctly or contact your local building & zoning department for information."),
    AfterProjectData(title: "Has the property been cleared and cleaned of all debris, materials, equipment, etc.?", description: "Before you give him the last payment, you might want to consider making sure that all your punch list items have been taken care of."),
    AfterProjectData(title: "Have all inspections been approved?", description: "It is a good idea for you to confirm that all inspections have been approved.  You can contact your local building & zoning department to confirm this."),
    AfterProjectData(title: "Have all lien waivers/releases been notarized and signed?", description: "It is an excellent idea to get lien waivers/releases signed by the contractor.  It shows that he has been paid and will not file a lien against your home for nonpayment.  You can always contact an attorney licensed in your state, to explain this to you."),
    AfterProjectData(title: "Do you have a final payment affidavit signed by the contractor and notarized?", description: "It is a good idea to get this to show you made all payments to the contractor."),
    AfterProjectData(title: "Do you have all your papers, i.e., warranties, etc.", description: "Good!  Make sure the contractor explains all warranties to you.  And make sure he explains exactly what his labor warranty is, not just the manufacturer’s warranties. It is a good idea to make sure the contractor explains all warranties to you.  And make sure he explains exactly what his labor warranty is, not just the manufacturer’s warranties."),
    AfterProjectData(title: "Do you have all applicable notices? Notice of Completion? Certificate of Occupancy? Etc.", description: "Sometimes, a Notice of Completion or Certificate of Occupancy is required.  You can contact your local Building & Zoning Department to determine if you need to get these documents from the contractor.")
]
