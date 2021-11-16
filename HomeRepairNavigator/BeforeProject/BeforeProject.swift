//
//  BeforeProject.swift
//  HomeRepairNavigator
//
//  Created by robevans on 11/15/21.
//

import SwiftUI

struct BeforeProject: View {
    @Environment(\.colorScheme) var colorScheme

    @State var showInfo = false

    @Binding var showButtons: Bool
    var body: some View {
        ZStack {
            Color("Background")
                .edgesIgnoringSafeArea(.all)
            VStack {
                Text("Before Project")
                    .bold()
                    .textCase(.uppercase)
                    .font(.largeTitle)
                ScrollView {
                    VStack(spacing: 20) {
                        ForEach(beforeProjectData) { data in
                            BeforeRowView(showInfo: $showInfo, title: data.title)
                        }
                    }
                }
            }
            if showInfo {
                InfoOverLay(showInfo: $showInfo, title: "title", question: "Question??", info: "Some Useful Info")
                    .padding()
                    .shadow(color: Color("Shadow").opacity(colorScheme == .dark ? 1.0 : 0.3), radius: 8, x: 0, y: 0)
            }
        }
    }
}

struct BeforeProject_Previews: PreviewProvider {
    static var previews: some View {
        BeforeProject(showButtons: .constant(false))
        BeforeProject(showButtons: .constant(false))
            .colorScheme(.dark)
    }
}

struct BeforeProjectData: Identifiable {
    var id = UUID()
    var title: String
    var description: String
}

var beforeProjectData = [
    BeforeProjectData(title: "Have you researched the project?", description: "We suggest you go to your local retailers and/or local homebuilder’s association and ask questions, so you have a better understanding of what it will take to do your project.  This is also a good time to pick out the items you want (i.e., style of granite, exact cabinets you want, stove, color of paint, etc.)"),
    BeforeProjectData(title: "Have you consulted with any architects or engineers?", description: "Sometimes, depending on your project, you may need to consult with specialists like architects, engineers, etc.  You can contact your local home building organizations and ask them for advice."),
    BeforeProjectData(title: "Have you gotten at least three estimates from contractors?", description: "Be careful if they ask you to sign something.  You don’t want a quote to become a contract you are obligated to.  We always suggest contacting an attorney if you are not sure what to do. We suggest getting at least three estimates from contractors which will help you determine how much you can expect to pay for your project.  You can get as many estimates as you like, but get at least three.  Be careful if they ask you to sign something.  You don’t want a quote to become a contract you are obligated to.  We always suggest contacting an attorney if you are not sure what to do."),
    BeforeProjectData(title: "Do these contractors specialize in the work you need to have done?", description: "It is a good idea to seek out a contractor who has experience in the work you need done. You might not want to hire a painter to install your electrical wiring or a plumber to build a new room onto your home.  Most jobs require expertise in that area."),
    BeforeProjectData(title: "Have you selected which contractor you are going to use?", description: "We suggest that you make sure you have a good feeling about the contractor you select.  We also suggest you search for them on the Internet to see what comes up.  Ask for references from subcontractors they have used.  Contact any local home improvement organizations and ask if they ever heard of him.  Do some homework on finding out as much as you can about the contractor.  There are many companies who can do a criminal background check and it doesn’t cost that much.  You might want to consider that."),
    BeforeProjectData(title: "Have you gotten references on the contractor?", description: "It is a good idea to get at least 3 references. You might ask for 3 references from jobs he has done in the last 6 months."),
    BeforeProjectData(title: "Have you verified the contractor’s insurance coverage? ", description: "Your personal insurance agent can help you make sure the contractor has appropriate insurance to do your project."),
    BeforeProjectData(title: "Have you verified that the contractor’s “business” license is active and compliant? ", description: "You can contact your Secretary of State’s office to confirm that the contractor is licensed to do business in your state."),
    BeforeProjectData(title: "Have you verified that the contractor’s “contractor’s” license is active and compliant, where applicable?", description: "You can contact your local building & zoning department to determine if the contractor’s license is active.  Keep in mind, some states don’t require a contractor to have this license.  And, the contractor’s license is different from a business license."),BeforeProjectData(title: "Have you verified the contractor is bonded, if applicable?", description: "Your personal insurance agent can help you determine what types of insurance/bond coverage the contractor has."),
    BeforeProjectData(title: "Have you considered purchasing a performance/completion bond, payment bond, etc.?", description: "You can contact your personal insurance agent to help you decide what types of coverages are best for you regarding your project.  Be sure to ask them what is covered under your current homeowner’s policy and what is not."),
    BeforeProjectData(title: "Has the contractor given you the names and background information of all subcontractors?", description: "You should know everyone who is coming to work on your property, including subcontractors."),
    BeforeProjectData(title: "Has the contractor given you a Scope of Work that details everything about the project (labor cost, supplies, taxes, permits, etc.)?", description: "Be sure to get a scope of work from the contractor.  It details everything that needs to be done and how much everything will cost.  You can always contact your local home building organizations or building & zoning department to give you information and answer any questions you may have."),
    BeforeProjectData(title: "Have you and the contractor agreed to a payment schedule?", description: "If you and the contractor have agreed to a payment schedule, it should be included in your contract. We strongly suggest you have an attorney licensed in your state review the payment schedule and contract with you as these are very important. You need to create a payment schedule and it should be included in your contract.  We strongly suggest you have an attorney licensed in your state review the payment schedule and contract.  This is very important."),
    BeforeProjectData(title: "Have you thoroughly reviewed and understand the contract?", description: "Never sign anything you don’t understand or disagree with.  We strongly suggest you have an attorney review the contract before you sign it."),
    BeforeProjectData(title: "Has your attorney reviewed the contract and advised you on it?", description: "Never sign anything you don’t understand or disagree with.  We strongly suggest you have an attorney review the contract before you sign it."),
    BeforeProjectData(title: "Have you taken pictures before any work begins?", description: "We suggest you take pictures before, during and after the project. We suggest you take pictures before, during and after the project."),
    BeforeProjectData(title: "Have you secured your valuables?", description: "We suggest you secure your valuables including any papers you have lying around with your personal information on it."),
    BeforeProjectData(title: "Do you have copies of all permits?", description: "We suggest you keep copies of all permits.  The contractor should give you copies.  You can also get copies from your local building & zoning department."),
    BeforeProjectData(title: "Have you started a daily progress journal?", description: "Be sure to include things like the weather, who was on site on what day/time, what work was done, who showed up late, etc.  We suggest you keep a daily log of the project.  Include things like the weather, who was on site on what day/time, what work was done, who showed up late, etc."),
    BeforeProjectData(title: "Are you taking pictures throughout the project?", description: "We suggest you take pictures before, during and after the project. We suggest you take pictures before, during and after the project."),
    BeforeProjectData(title: "Are you getting regular updates of the progress from the contractor?", description: "We suggest you communicate regularly with the contractor, so he can keep you up to date on the progress of the project."),
    BeforeProjectData(title: "Are you getting all change orders in writing?", description: "We suggest that you get all change orders in writing and add them to the contract.  If you are not sure about something, you can contact your attorney to make sure any change orders become part of the contract."),
    BeforeProjectData(title: "Has the project been completed?", description: "It is a good idea to inspect the project to make sure it is done to your liking.  If you are unsure about something, you might consider hiring an inspector to verify that the job has been done correctly or contact your local building & zoning department for information."),
    BeforeProjectData(title: "Has the property been cleared and cleaned of all debris, materials, equipment, etc.?", description: "Before you give him the last payment, you might want to consider making sure that all your punch list items have been taken care of."),
    BeforeProjectData(title: "Have all inspections been approved?", description: "It is a good idea for you to confirm that all inspections have been approved.  You can contact your local building & zoning department to confirm this."),
    BeforeProjectData(title: "Have all lien waivers/releases been notarized and signed?", description: "It is an excellent idea to get lien waivers/releases signed by the contractor.  It shows that he has been paid and will not file a lien against your home for nonpayment.  You can always contact an attorney licensed in your state, to explain this to you."),
    BeforeProjectData(title: "Do you have a final payment affidavit signed by the contractor and notarized?", description: "It is a good idea to get this to show you made all payments to the contractor."),
    BeforeProjectData(title: "Do you have all your papers, i.e., warranties, etc.", description: "Good!  Make sure the contractor explains all warranties to you.  And make sure he explains exactly what his labor warranty is, not just the manufacturer’s warranties. It is a good idea to make sure the contractor explains all warranties to you.  And make sure he explains exactly what his labor warranty is, not just the manufacturer’s warranties."),
    BeforeProjectData(title: "Do you have all applicable notices? Notice of Completion? Certificate of Occupancy? Etc.", description: "Sometimes, a Notice of Completion or Certificate of Occupancy is required.  You can contact your local Building & Zoning Department to determine if you need to get these documents from the contractor.")

]
