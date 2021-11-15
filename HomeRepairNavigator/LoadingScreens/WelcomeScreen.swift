//
//  WelcomeScreen.swift
//  HomeRepairNavigator
//
//  Created by robevans on 11/15/21.
//

import SwiftUI

struct WelcomeScreen: View {
    var body: some View {
        VStack {
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
            Button(action: {}) {
                ButtonTextView(text: "Continue")
                    .padding(.horizontal)
            }
        }
    }
}

struct WelcomeScreen_Previews: PreviewProvider {
    static var previews: some View {
        WelcomeScreen()
    }
}
