//
//  WelcomeScreen.swift
//  HomeRepairNavigator
//
//  Created by robevans on 11/15/21.
//

import SwiftUI

struct WelcomeScreen: View {
    @AppStorage("UserDefault_FirstRun") var showFirstRun = true
    @AppStorage("UserDefault_ShowTerms") var showTerms = true

    @Binding var showWelcomeScreen: Bool

    var body: some View {
        ZStack {
            Color("Background")
                .edgesIgnoringSafeArea(.all)
            VStack {
                Image("naahrf-logo")
                    .resizable()
                    .frame(width: 145, height: 145, alignment: .center)
                    .aspectRatio(contentMode: .fit)
                Group {
                    Text("Home Repair Navigator")
                        .font(.title)
                        .bold()
                        .padding(.bottom)
                    Text("Welcome to the Home Repair Navigator! This app will walk you through the process of dealing with contractors to help you avoid being ripped off or losing your hard earned money.")
                        .padding()
                    Text("The app is very easy to use.")
                        .padding()
                    Text("This app is brought to you by the National Alliance Against Home Repair Fraud, a 501(c)(3) nonprofit whose mission is to help protect homeowners from becoming victims of home repair fraud and scams.")
                        .padding()
                    Button(action: {
                        showFirstRun = false
                        showWelcomeScreen = false
                    }) {
                        ButtonTextView(smallButton: false, text: "Continue")
                            .padding(.horizontal)
                    }
                }
            }
            .fullScreenCover(isPresented: $showTerms,
                onDismiss: { print("dismissed!") },
                             content: { AgreementView(agreement: .constant(false)) })
        }
    }
}

struct WelcomeScreen_Previews: PreviewProvider {
    static var previews: some View {
        WelcomeScreen(showWelcomeScreen: .constant(false))
        WelcomeScreen(showWelcomeScreen: .constant(false))
            .colorScheme(.dark)
    }
}
