//
//  BeforeRowView.swift
//  HomeRepairNavigator
//
//  Created by robevans on 11/15/21.
//

import SwiftUI


struct BeforeRowView: View {
    @State var showButtons = false
    @Binding var showInfo: Bool
    let title: String
    
    var body: some View {
        ZStack {
            Color("Background")
                .edgesIgnoringSafeArea(.all)
            VStack {
                HStack {
                    Text(title)
                        .padding()
                        .frame(maxWidth: .infinity)
                    Button(action: {
                        withAnimation {
                            showButtons.toggle()
                        }
                    }) {
                        Image(systemName: showButtons ? "chevron.down" : "chevron.right")
                            .padding(.trailing,8)
                    }
                    Spacer()
                }
                if showButtons {
                    HStack {
                        Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/) {
                            ButtonTextView(text: "Yes")
                        }
                        Button(action: {
                            withAnimation {
                                showInfo = true
                            }
                        }) {
                            ButtonTextView(text: "No")
                        }
                        Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/) {
                            ButtonTextView(text: "Don't Know")
                        }
                    }
                    .padding()
                }
            }
            .overlay(
                RoundedRectangle(cornerRadius: 8)
                    .stroke(.secondary, lineWidth: 1)
            )
            .padding(.horizontal)
        }
    }
}

struct BeforeRowView_Previews: PreviewProvider {
    static var previews: some View {
        BeforeRowView(showInfo: .constant(false), title: "Before Project")
        BeforeRowView(showInfo: .constant(false), title: "Before Project")
            .colorScheme(.dark)
    }
}
