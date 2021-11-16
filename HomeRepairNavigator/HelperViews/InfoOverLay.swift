//
//  InfoOverLay.swift
//  HomeRepairNavigator
//
//  Created by robevans on 11/15/21.
//

import SwiftUI

struct InfoOverLay: View {
    @Environment(\.colorScheme) var colorScheme
    @Binding var showInfo: Bool
    let title: String
    let question: String
    let info: String

    var body: some View {
        GeometryReader { geo in
            ZStack {
                Color("Background")
                VStack {
                    Text(title)
                        .font(.title)
                        .fontWeight(.semibold)
                        .padding(.top, 8)
                    Spacer()
                    Text(question)
                    Text(info)
                    Button(action: {
                        withAnimation {
                            showInfo = false
                        }
                    }) {
                        ButtonTextView(text: "OK")
                            .padding()
                    }
                    Spacer()
                }
            }
            .frame(width: geo.size.width - 30, height: 300, alignment: .center)
            .cornerRadius(13)
            .position(x: geo.size.width / 2, y: geo.size.height / 2)
            .shadow(color: Color("Shadow").opacity(colorScheme == .dark ? 1.0 : 0.3), radius: 3, x: 0, y: 0)
        }
    }
}

struct InfoOverLay_Previews: PreviewProvider {
    static var previews: some View {
        InfoOverLay(showInfo: .constant(false), title: "title", question: "question?", info: "info")
        InfoOverLay(showInfo: .constant(false), title: "title", question: "question?", info: "info")
            .colorScheme(.dark)
    }
}
