//
//  CompletionView.swift
//  HomeRepairNavigator
//
//  Created by robevans on 11/23/21.
//

import SwiftUI

struct CompletionView: View {
    @Environment(\.colorScheme) var colorScheme

    var body: some View {
        ZStack {
            Color("Background")
                .edgesIgnoringSafeArea(.all)
            VStack {
                Text("Thank you for using \nHome Repair Helper!")
                    .font(.title)
                    .bold()
                    .kerning(2)
                    .padding()
                ZStack {
                    Color("Foreground")
                        .cornerRadius(13)
                        .shadow(color: Color("Shadow").opacity(colorScheme == .dark ? 1.0 : 0.6), radius: 3, x: 0, y: 0)
                        .shadow(color: Color("Shadow").opacity(colorScheme == .dark ? 1.0 : 0.3), radius: 6, x: 0, y: 0)
                    HStack {
                        Image("AmazonBook")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .clipShape(RoundedRectangle(cornerRadius: 13))
                            .frame(width: 115, height: 170, alignment: .center)
                            .shadow(color: Color("Shadow").opacity(colorScheme == .dark ? 1.0 : 0.3), radius: 6, x: 0, y: 0)
                        Text("For more information, including how to set up a payment schedule, purchase our step-by-step guidebook **“Don’t Even Think About Ripping Me Off!”** from Amazon or Barnes & Noble for $14.95.")
                            .font(.callout)
                    }
                }
                .frame(height: 200)
                .padding(.horizontal)
                Text("Be sure to share our app with your family, friends, neighbors, co-workers so we can help protect them too! \n\nWe hope that it has helped you during your project. We ask that you consider donating to NAAHRF a 501(c)(3)")
                    .padding()
                HStack{
                    FooterImage(text: "Amazon", image: "link.circle")
                    Spacer()
                    FooterImage(text: "Donate", image: "dollarsign.circle")
                    Spacer()
                    FooterImage(text: "Visit", image: "globe")
                    Spacer()
                    FooterImage(text: "Share", image: "square.and.arrow.up")
                }
                .padding(.horizontal)
                Spacer()
            }
        }
    }
}

struct CompletionView_Previews: PreviewProvider {
    static var previews: some View {
        CompletionView()
        CompletionView()
            .colorScheme(.dark)
    }
}
