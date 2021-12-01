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
                ScrollView {
                VStack {
                    Text("Thank you for using \nHome Repair Helper!")
                        .font(.title)
                        .bold()
                        .kerning(2)
                        .padding()
                        .padding(.top)
                    ZStack {
                        Color("Foreground")
                            .cornerRadius(13)
                            .shadow(color: Color("Shadow").opacity(colorScheme == .dark ? 1.0 : 0.3), radius: 6, x: 0, y: 0)
                        HStack {
                            Image("AmazonBook")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .clipShape(RoundedRectangle(cornerRadius: 13))
                                .frame(width: 115, height: 170, alignment: .center)
                                .shadow(color: Color("Shadow").opacity(colorScheme == .dark ? 1.0 : 0.3), radius: 6, x: 0, y: 0)
                            VStack {
                                Text("For more information, including how to set up a payment schedule, purchase our step-by-step guidebook **“Don’t Even Think About Ripping Me Off!”** from Amazon or Barnes & Noble for $14.95.")
                                    .font(.callout)
                                Link("Amazon", destination: URL(string: "https://www.amazon.com/dp/B00SM5GDV0/ref=dp-kindle-redirect?_encoding=UTF8&btkr=1")!)
                            }
                        }
                    }
                    .frame(height: 200)
                    .padding(.horizontal)
                    Text("We hope that you found the Home Repair Helper a helpful tool!  Keep the app handy.  We will continue to update and upgrade it, so it is even more helpful for your next project. \n\nBe sure to tell everyone you know about the app.  We don’t want anyone you know to be taken advantage of by a shady contractor.\n\nLastly, we hope we helped save your money, time, and home from a shady contractor, and our nonprofit is worthy of your donation.")
                        .padding()
                    Divider()
                    HStack{
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
        .edgesIgnoringSafeArea(.all)
    }
}

struct CompletionView_Previews: PreviewProvider {
    static var previews: some View {
        CompletionView()
        CompletionView()
            .colorScheme(.dark)
    }
}
