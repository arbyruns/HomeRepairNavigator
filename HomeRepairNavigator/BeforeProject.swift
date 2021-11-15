//
//  BeforeProject.swift
//  HomeRepairNavigator
//
//  Created by robevans on 11/15/21.
//

import SwiftUI

struct BeforeProject: View {
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

struct BeforeProject_Previews: PreviewProvider {
    static var previews: some View {
        BeforeProject()
    }
}


struct BeforeProjectData: Identifiable {
    var id = UUID()
    var title: String
    var description: String
}

var beforeProjectData = [
    BeforeProjectData(title: "Have you researched the project", description: <#T##String#>)

]
