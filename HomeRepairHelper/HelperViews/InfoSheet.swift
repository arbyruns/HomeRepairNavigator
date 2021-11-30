//
//  InfoSheet.swift
//  HomeRepairNavigator
//
//  Created by robevans on 11/16/21.
//

import SwiftUI
import Lottie

struct InfoSheet: View {
    @Environment(\.colorScheme) var colorScheme
    @ObservedObject var infoOverlay: OverLayInfo

    @Binding var showInfo: Bool
    
    var body: some View {
            ZStack {
                Color("Background")
                VStack {
                    Spacer()
                    LottieView(filename: "11202-information")
                        .frame(width: 115, height: 115, alignment: .center)
                        .shadow(color: Color("Shadow").opacity(colorScheme == .dark ? 1.0 : 0.6), radius: 3, x: 0, y: 0)
                    Text(infoOverlay.title)
                        .frame(maxWidth: .infinity)
                        .foregroundColor(Color("FontColor"))
                        .font(.title)
                        .padding()
                    Divider()
                    Text(infoOverlay.description)
                        .foregroundColor(Color("FontColor"))
                        .font(.title3)
                        .padding(.horizontal, 8)
                    Spacer()
                    Button(action: {
                        withAnimation {
                            showInfo = false
                        }
                    }) {
                        ButtonTextView(smallButton: false, text: "OK")
                            .padding()
                    }
                }
            }
            .cornerRadius(13)
            .shadow(color: Color("Shadow").opacity(colorScheme == .dark ? 1.0 : 0.3), radius: 3, x: 0, y: 0)
    }
}

struct InfoSheet_Previews: PreviewProvider {
    static var previews: some View {
        InfoSheet(infoOverlay: OverLayInfo(), showInfo: .constant(false))
        InfoSheet(infoOverlay: OverLayInfo(), showInfo: .constant(false))
            .colorScheme(.dark)
    }
}

