//
//  InfoOverLay.swift
//  HomeRepairNavigator
//
//  Created by robevans on 11/15/21.
//

import SwiftUI

struct InfoOverLay: View {
    @Environment(\.colorScheme) var colorScheme

    let completedArray = UserDefaults.standard.object(forKey: "userDefault-completedItems") as? [Int] ?? [Int]()

    var body: some View {
        VStack {
            ForEach(completedArray, id: \.self) { index in
                Text("\(index)")

            }
        }
    }
}

struct InfoOverLay_Previews: PreviewProvider {
    static var previews: some View {
        InfoOverLay()
        InfoOverLay()
            .colorScheme(.dark)
    }
}

class OverLayInfo: ObservableObject {
    @Published var title = "Has the project been completed?"
    @Published var description = "You can contact your local building & zoning department to determine if the contractor’s license is active.  Keep in mind, some states don’t require a contractor to have this license.  And, the contractor’s license is different from a business license."
}
