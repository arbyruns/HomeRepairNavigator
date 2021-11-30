//
//  About.swift
//  HomeRepairNavigator
//
//  Created by robevans on 11/22/21.
//

import SwiftUI

struct AboutView: View {
    @Binding var showProjectHelp: Bool

    var body: some View {
        ZStack {
            Color("Background")
                .edgesIgnoringSafeArea(.all)
            VStack {
                Text("About")
                    .font(.largeTitle)
                    .bold()
                Text("This is a placeholder on why we collect this information.")
            }
        }
    }
}

struct About_Previews: PreviewProvider {
    static var previews: some View {
        AboutView(showProjectHelp: .constant(false))
    }
}
