//
//  ConfirmationScreen.swift
//  HomeRepairNavigator
//
//  Created by robevans on 11/22/21.
//

import SwiftUI

struct ConfirmationScreen: View {
    @Environment(\.colorScheme) var colorScheme
    @AppStorage("UserDefault_FirstRun") var showFirstRun = true

    @StateObject var telemtryData = TelemetryData()

    @Binding var showConfirmation: Bool
    @Binding var zipCode: String
    @Binding var userProject: String
    @Binding var userBudget: String

    var body: some View {
        GeometryReader { geo in
            ZStack {
                Color("Background")
                    .edgesIgnoringSafeArea(.all)
                VStack {
                    LottieView(filename: "42564-thanks-button")
                        .frame(width: 175, height: 55, alignment: .center)
                    Text("This information will assist with applying for grants and to help others in need.")
                    Button(action: {
                        playHaptic(style: "medium")
                        withAnimation {
                            telemtryData.sendProject(project: userProject)
                            telemtryData.sendZipCode(zipCode: zipCode)
                            telemtryData.sendBudget(budget: userBudget)
                            telemtryData.sendMeta()
                            showConfirmation = false
                            showFirstRun = false
                        }
                    }) {
                        ButtonTextView(smallButton: false, text: "Submit")
                            .padding()
                    }
                }
            }
            .frame(width: geo.size.width - 30, height: 400, alignment: .center)
            .cornerRadius(13)
            .position(x: geo.size.width / 2, y: geo.size.height / 2)
            .shadow(color: Color("Shadow").opacity(colorScheme == .dark ? 1.0 : 0.3), radius: 3, x: 0, y: 0)
        }
    }
}

struct ConfirmationScreen_Previews: PreviewProvider {
    static var previews: some View {
        ConfirmationScreen(showConfirmation: .constant(false), zipCode: .constant("12232"), userProject: .constant("fire"), userBudget: .constant("1313"))
    }
}
