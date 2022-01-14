//
//  Data.swift
//  HomeRepairHelper
//
//  Created by robevans on 1/13/22.
//

import Foundation


class ProjectData: ObservableObject {
    @Published var projectName = ""
    @Published var projectID = 0
    @Published var projectType = ""
    @Published var projectBudget = ""
    @Published var completedTask = false
}
