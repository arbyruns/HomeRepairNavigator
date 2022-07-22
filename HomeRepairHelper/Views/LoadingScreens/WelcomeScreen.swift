//
//  WelcomeScreen.swift
//  HomeRepairNavigator
//
//  Created by robevans on 11/15/21.
//

import SwiftUI

struct WelcomeScreen: View {

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
                    .aspectRatio(contentMode: .fill)
                Group {
                    Text("Home Repair Helper ™")
                        .font(.title)
                        .bold()
                        .padding(.bottom)
                    Text("Welcome to the **Home Repair Helper ™!** This app will walk you through the process of dealing with contractors to help you avoid being ripped off or losing your hard earned money.\n\nCopyright©2021")
                        .padding()
                    Text("This app is brought to you by the National Alliance Against Home Repair Fraud, a 501(c)(3) nonprofit whose mission is to help protect homeowners from becoming victims of home repair fraud and scams.")
                        .padding()
                }
            }
        }
    }
}

struct WelcomeScreen_Previews: PreviewProvider {
    static var previews: some View {
        WelcomeScreen()
        WelcomeScreen()
            .colorScheme(.dark)
    }
}
