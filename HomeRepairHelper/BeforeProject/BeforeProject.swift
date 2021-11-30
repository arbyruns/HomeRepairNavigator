//
//  BeforeProject.swift
//  HomeRepairNavigator
//
//  Created by robevans on 11/15/21.
//

import SwiftUI
import Foundation
import SwiftUINavigationBarStyling

struct BeforeProject: View {
    @Environment(\.colorScheme) var colorScheme
    @ObservedObject var infoOverLayInfo: OverLayInfo

    @State var showInfo = false
    @State var showSheet = false
    @State var showProjectSheet = false
    @Binding var showButtons: Bool
    @Binding var completed: Bool
    let completedArray = UserDefaults.standard.object(forKey: "userDefault-completedItems") as? [Int] ?? [Int]()


    var body: some View {
            ZStack {
                Color("Background")
                NavigationView {
                VStack {
                    ScrollView {
                        VStack(spacing: 20) {
                                ForEach(beforeProjectData) { data in
                                    ProjectRowView(infoOverLayInfo: infoOverLayInfo,
                                                   showInfo: $showInfo,
                                                   showSheet: $showSheet,
                                                   showCompletedSheet: .constant(false),
                                                   title: data.title,
                                                   question: data.title,
                                                   info: data.description,
                                                   completedID: data.trackingID
                                                   )
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
//                .sheet(isPresented: $showProjectSheet,
//                       onDismiss:  { self.showButtons = false },
//                       content: {
//                    ProjectOnboardView(showProject: $showProjectSheet)
//                })
                .navigationTitle("Before Project")
                .navigationBarTitleDisplayMode(.inline)
                .navigationBarItems(trailing:
                                        Button(action: {
                    showProjectSheet = true
                    playHaptic(style: "medium")
                }) {
                    Image(systemName: "rectangle.and.pencil.and.ellipsis")
                        .font(.title3)
                })
                .navigationBarColor(colorScheme == .dark ? UIColor(Color("borderColor")) : UIColor(Color("buttonColorCyan")), textColor: UIColor(Color("FontColor")))
            }
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

struct BeforeProject_Previews: PreviewProvider {
    static var previews: some View {
        BeforeProject(infoOverLayInfo: OverLayInfo(), showButtons: .constant(false), completed: .constant(false))
        BeforeProject(infoOverLayInfo: OverLayInfo(), showButtons: .constant(false), completed: .constant(false))
            .colorScheme(.dark)
    }
}

struct BeforeProjectData: Identifiable {
    let id = UUID()
    var trackingID: Int
    var title: String
    var description: String
}

var beforeProjectData = [
    BeforeProjectData(trackingID: 1, title: "Have you researched the project?", description: "We suggest you go to your local retailers and/or local homebuilder’s association and ask questions, so you have a better understanding of what it will take to do your project.  This is also a good time to pick out the items you want (i.e., style of granite, exact cabinets you want, stove, color of paint, etc.)"),
        BeforeProjectData(trackingID: 2, title: "Have you consulted with any architects or engineers?", description: "Sometimes, depending on your project, you may need to consult with specialists like architects, engineers, etc.  You can contact your local home building organizations and ask them for advice."),
        BeforeProjectData(trackingID: 3, title: "Have you gotten at least three estimates from contractors?", description: "Be careful if they ask you to sign something.  You don’t want a quote to become a contract you are obligated to.  We always suggest contacting an attorney if you are not sure what to do. We suggest getting at least three estimates from contractors which will help you determine how much you can expect to pay for your project. You can get as many estimates as you like, but get at least three."),
        BeforeProjectData(trackingID: 4, title: "Do these contractors specialize in the work you need to have done?", description: "It is a good idea to seek out a contractor who has experience in the work you need done. You might not want to hire a painter to install your electrical wiring or a plumber to build a new room onto your home.  Most jobs require expertise in that area."),
        BeforeProjectData(trackingID: 5, title: "Have you selected which contractor you are going to use?", description: "We suggest that you make sure you have a good feeling about the contractor you select. We also suggest you search for them on the Internet to see what comes up.  Ask for references from subcontractors they have used.  Contact any local home improvement organizations and ask if they ever heard of him. Do some homework on finding out as much as you can about the contractor.  There are many companies who can do a criminal background check and it doesn’t cost that much.  You might want to consider that."),
        BeforeProjectData(trackingID: 6, title: "Have you gotten references on the contractor?", description: "It is a good idea to get at least 3 references. You might ask for 3 references from jobs he has done in the last 6 months."),
        BeforeProjectData(trackingID: 7, title: "Have you verified the contractor’s insurance coverage? ", description: "Your personal insurance agent can help you make sure the contractor has appropriate insurance to do your project."),
        BeforeProjectData(trackingID: 8, title: "Have you verified that the contractor’s “business” license is active and compliant? ", description: "You can contact your Secretary of State’s office to confirm that the contractor is licensed to do business in your state."),
        BeforeProjectData(trackingID: 9, title: "Have you verified that the contractor’s “contractor’s” license is active and compliant, where applicable?", description: "You can contact your local building & zoning department to determine if the contractor’s license is active.  Keep in mind, some states don’t require a contractor to have this license.  And, the contractor’s license is different from a business license."),
    BeforeProjectData(trackingID: 10, title: "Have you verified the contractor is bonded, if applicable?", description: "Your personal insurance agent can help you determine what types of insurance/bond coverage the contractor has."),
        BeforeProjectData(trackingID: 11, title: "Have you considered purchasing a performance/completion bond, payment bond, etc.?", description: "You can contact your personal insurance agent to help you decide what types of coverages are best for you regarding your project.  Be sure to ask them what is covered under your current homeowner’s policy and what is not."),
        BeforeProjectData(trackingID: 12, title: "Has the contractor given you the names and background information of all subcontractors?", description: "You should know everyone who is coming to work on your property, including subcontractors."),
        BeforeProjectData(trackingID: 13, title: "Has the contractor given you a Scope of Work that details everything about the project (labor cost, supplies, taxes, permits, etc.)?", description: "Be sure to get a scope of work from the contractor.  It details everything that needs to be done and how much everything will cost. You can always contact your local home building organizations or building & zoning department to give you information and answer any questions you may have."),
        BeforeProjectData(trackingID: 14, title: "Have you and the contractor agreed to a payment schedule?", description: "If you and the contractor have agreed to a payment schedule, it should be included in your contract. We strongly suggest you have an attorney licensed in your state review the payment schedule and contract with you as these are very important. You need to create a payment schedule and it should be included in your contract. We strongly suggest you have an attorney licensed in your state review the payment schedule and contract. This is very important."),
        BeforeProjectData(trackingID: 15, title: "Have you thoroughly reviewed and understand the contract?", description: "Never sign anything you don’t understand or disagree with. We strongly suggest you have an attorney review the contract before you sign it."),
        BeforeProjectData(trackingID: 16, title: "Has your attorney reviewed the contract and advised you on it?", description: "Never sign anything you don’t understand or disagree with. We strongly suggest you have an attorney review the contract before you sign it.")
]
