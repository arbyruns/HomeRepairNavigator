//
//  WelcomeScreen_2.swift
//  HomeRepairNavigator
//
//  Created by robevans on 11/15/21.
//

import SwiftUI

struct AgreementView: View {
    @AppStorage("UserDefault_FirstRun") var showFirstRun = true
    @AppStorage("UserDefault_ShowTerms") var showTerms = true
    @Binding var agreement: Bool

    var body: some View {
        ZStack {
            Color("Background")
                .edgesIgnoringSafeArea(.all)
            VStack {
                Image("naahrf-logo")
                    .resizable()
                    .frame(width: 145, height: 145, alignment: .center)
                    .aspectRatio(contentMode: .fit)
                Text("Home Repair Navigator")
                    .font(.title)
                    .bold()
                    .padding(.bottom)
                Text("All information contained in this app is for informational purposes only and should in no way be considered legal advice")
                    .padding()
                Text("The general information contained herein may not be suitable for every situation. State laws vary, so we highly recommend you contact a licensed legal professional in your state for any professional or legal advice regarding your home repair project, especially before you sign any documentation or enter into any agreements with home repair service providers.")
                    .padding()
                Button(action: {
                    showTerms = false
                    agreement = false
                    playHaptic(style: "medium")
                }) {
                    ButtonTextView(smallButton: false, text: "I Accept")
                        .padding(.horizontal)
                }
            }
        }
    }
}

struct AgreementView_Previews: PreviewProvider {
    static var previews: some View {
        AgreementView(agreement: .constant(false))
        AgreementView(agreement: .constant(false))
            .colorScheme(.dark)
    }
}
