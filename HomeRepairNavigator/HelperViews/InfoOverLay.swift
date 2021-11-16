//
//  InfoOverLay.swift
//  HomeRepairNavigator
//
//  Created by robevans on 11/15/21.
//

import SwiftUI

struct InfoOverLay: View {
    @Environment(\.colorScheme) var colorScheme
    @ObservedObject var infoOverlay: OverLayInfo


    @Binding var showInfo: Bool

    var body: some View {
        GeometryReader { geo in
            ZStack {
                Color("Background")
                VStack {
                    Spacer()
                    Text(infoOverlay.title)
                        .foregroundColor(Color("FontColor"))
                        .padding()
                        .font(.title2)
                    Divider()
                        .frame(width: geo.size.width - 95)
                    Text(infoOverlay.description)
                        .foregroundColor(Color("FontColor"))
                        .font(.subheadline)
                        .padding(.horizontal, 8)
                    Spacer()
                    Button(action: {
                        withAnimation {
                            showInfo = false
                        }
                    }) {
                        ButtonTextView(text: "OK")
                            .padding()
                    }
                }
            }
            .frame(width: geo.size.width - 30, height: geo.size.height / 2, alignment: .center)
            .cornerRadius(13)
            .position(x: geo.size.width / 2, y: geo.size.height / 2)
            .shadow(color: Color("Shadow").opacity(colorScheme == .dark ? 1.0 : 0.3), radius: 3, x: 0, y: 0)
        }
    }
}

struct InfoOverLay_Previews: PreviewProvider {
    static var previews: some View {
        InfoOverLay(infoOverlay: OverLayInfo(), showInfo: .constant(false))
        InfoOverLay(infoOverlay: OverLayInfo(), showInfo: .constant(false))
            .colorScheme(.dark)
    }
}

class OverLayInfo: ObservableObject {
    @Published var title = "Has the project been completed?"
    @Published var description = "You can contact your local building & zoning department to determine if the contractor’s license is active.  Keep in mind, some states don’t require a contractor to have this license.  And, the contractor’s license is different from a business license."
}
