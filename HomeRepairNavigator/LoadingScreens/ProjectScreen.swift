//
//  ProjectScreen.swift
//  HomeRepairNavigator
//
//  Created by robevans on 11/16/21.
//

import SwiftUI

struct ProjectScreen: View {
    @State var items: [String] = ["Fire", "Flood", "Tornado/Storm", "Hurricane", "Emergency Repair", "Non-Emergency Repair", "Remodel/Improvement"]
    @State var selections: [String] = []

    var body: some View {
        VStack {
            Text("Please indicate what type of project you need. Select all that apply")
            List {
                ForEach(self.items, id: \.self) { item in
                    MultipleSelectionRow(title: item, isSelected: self.selections.contains(item)) {
                        if self.selections.contains(item) {
                            self.selections.removeAll(where: { $0 == item })
                        }
                        else {
                            self.selections.append(item)
                        }
                    }
                }
            }
        }
    }
}

struct ProjectScreen_Previews: PreviewProvider {
    static var previews: some View {
        ProjectScreen()
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
