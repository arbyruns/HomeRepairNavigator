//
//  ProjectScreen.swift
//  HomeRepairNavigator
//
//  Created by robevans on 11/16/21.
//

import SwiftUI

struct ProjectTypeView: View {
    @Environment(\.colorScheme) var colorScheme

    @State var selections = ""
    @Binding var userProject: String

    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]


    var body: some View {
        ZStack {
            Color("Background")
                .edgesIgnoringSafeArea(.all)
            VStack(spacing: 20) {
                Text("Please indicate what type of project you need.")
                    LazyVGrid(columns: columns, spacing: 20) {
                        ForEach(projectItems) { item in
                            ItemView(selection: $userProject, text: item.item, image: item.image)
                        }
                    }
                    .padding(.top)
                Spacer()
            }
            .tabViewStyle(PageTabViewStyle())
//            .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .always))
        }
    }
}

struct MultipleSelectionRow: View {
    var title: String
    var isSelected: Bool
    var action: () -> Void

    var body: some View {
        Button(action: self.action) {
            HStack {
                Text(self.title)
                if self.isSelected {
                    Spacer()
                    Image(systemName: "checkmark")
                }
            }
        }
        .buttonStyle(PlainButtonStyle())
    }
}

struct ItemView: View {
    @Environment(\.colorScheme) var colorScheme

    @Binding var selection: String
    let text: String
    let image: String

    var body: some View {
        RoundedRectangle(cornerRadius: 13, style: .continuous)
//                .stroke(style: StrokeStyle(lineWidth: 2))
            .fill(selection == text ? Color("buttonColorRed") : Color("Background"))
            .shadow(color: Color("Shadow").opacity(colorScheme == .dark ? 1.0 : 0.6), radius: 3, x: 0, y: 0)
            .shadow(color: Color("Shadow").opacity(colorScheme == .dark ? 1.0 : 0.3), radius: 6, x: 0, y: 0)
            .frame(width: 155, height: 65)
            .overlay(
                VStack {
                    HStack {
                        Image(systemName: image)
                        Text(text)
                            .font(.subheadline)
                    }
                    .font(.title2)
                }
            )
            .onTapGesture {
                playHaptic(style: "light")
                withAnimation {
                    if selection == text {
                        selection = ""
                    } else {
                        selection = text
                    }
                }
            }
    }
}

struct ProjectInfo: Identifiable {
    let id = UUID()
    var item: String
    var image: String
}

var projectItems = [
    ProjectInfo(item: "Fire", image: "flame"),
    ProjectInfo(item: "Flood", image: "drop"),
    ProjectInfo(item: "Tornado/Storm", image: "tornado"),
    ProjectInfo(item: "Hurricane", image: "hurricane"),
    ProjectInfo(item: "Emergency Repair", image: "exclamationmark.octagon"),
    ProjectInfo(item: "Non-Emergency Repair", image: "hammer"),
    ProjectInfo(item: "Remodel/Improvement", image: "house")
]

struct ProjectScreen_Previews: PreviewProvider {
    static var previews: some View {
        ProjectTypeView(userProject: .constant("nil"))
        ProjectTypeView(userProject: .constant("nil"))
            .colorScheme(.dark)
    }
}
