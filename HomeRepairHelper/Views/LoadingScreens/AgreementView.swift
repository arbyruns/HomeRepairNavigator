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

    private enum Params {
        static let logo = "naahrf_logo_2.0"
    }

    var body: some View {
        ZStack {
            Color("Background")
                .edgesIgnoringSafeArea(.all)
            VStack {
                Image(Params.logo)
                    .resizable()
                    .frame(width: 200, height: 200, alignment: .center)
                    .aspectRatio(contentMode: .fit)
                Text("Home Repair Helper ™")
                    .font(.title)
                    .bold()
                    .padding(.bottom)
                Text("All information contained in this app is for informational purposes only and should in no way be considered legal advice")
                    .padding()
                Text("The general information contained herein may not be suitable for every situation. State laws vary, so we highly recommend you contact a licensed legal professional in your state for any professional or legal advice regarding your home repair project, especially before you sign any documentation or enter into any agreements with home repair service providers.")
                    .padding()
            }
        }
    }
}

struct AgreementView_Previews: PreviewProvider {
    static var previews: some View {
        AgreementView()
        AgreementView()
            .colorScheme(.dark)
    }
}
