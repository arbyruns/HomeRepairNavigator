//
//  FooterImage.swift
//  HomeRepairNavigator
//
//  Created by robevans on 11/24/21.
//

import SwiftUI

struct FooterImage: View {
    @Environment(\.openURL) var openURL

    let text: String
    let image: String
    var body: some View {
        VStack {
            Button(action: {

                switch text {
                case "Amazon":
                    openURL(URL(string: "https://www.amazon.com/dp/B00SM5GDV0/ref=dp-kindle-redirect?_encoding=UTF8&btkr=1")!)
                case "Donate":
                    openURL(URL(string: "https://www.paypal.com/fundraiser/charity/1381672")!)
                case "Visit":
                    openURL(URL(string: "https://naahrf.org/")!)
                default:
                    HomeRepairHelper.actionSheet()
                }

            }) {
                ZStack {
                    Color.gray
                        .opacity(0.4)
                        .frame(width: 85, height: 65, alignment: .center)
                        .clipShape(RoundedRectangle(cornerRadius: 13))
                    VStack {
                        Image(systemName: image)
                            .font(.title2)
                        Text(text)
                            .font(.subheadline)
                    }
                }
            }
        }
    }
}


struct FooterImage_Previews: PreviewProvider {
    static var previews: some View {
        FooterImage(text: "Bell", image: "bell")
    }
}
