//
//  CoreDataManager.swift
//  HomeRepairHelper
//
//  Created by robevans on 1/12/22.
//

import CoreData
import Foundation
import SwiftUI


class CoreDataManager: ObservableObject {

    let container: NSPersistentContainer

    @Published var savedEntities: [Item] = []

    init() {
        container = NSPersistentContainer(name: "homerepair")
        container.loadPersistentStores { (description, error) in
            if let error = error {
               print("error loading core data\(error.localizedDescription)")
            }
        }
        // Cloudkit
        container.viewContext.automaticallyMergesChangesFromParent = true
        // merged conflicts
        container.viewContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy

        fetchData()
    }

    func fetchData() {
        let fetchRequest = NSFetchRequest<Item>(entityName: "Item")
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "projectCreatedDate", ascending: true)]
        do {
            print("fetch data")
            savedEntities = try container.viewContext.fetch(fetchRequest)
            print(savedEntities)
        } catch let error {
            print("error fetching. \(error.localizedDescription)")
        }
    }

    func saveData() {
        do {
            try container.viewContext.save()
            fetchData()
        } catch let error {
            print("error saving. \(error)")
        }
    }

    func deleteItem(indexSet: IndexSet) {
        guard let index = indexSet.first else {
            return
        }
        let entity = savedEntities[index]
        container.viewContext.delete(entity)
        saveData()
    }

// MARK: Pertaining to HRH

    func saveProject(projectName: String, projectBudget: String, ProjectType: String, projectZip: Int) {
        let newProject = Item(context: container.viewContext)

        newProject.projectZip = Int32(projectZip)
        newProject.projectName = projectName
        newProject.projectBudget = projectBudget
        newProject.projectType = ProjectType
        newProject.projectUID = generateProjectID()
        newProject.projectCreatedDate = Date()
        newProject.completedItems = []
        newProject.notes = []
        saveData()
    }

    func saveTask(_ entity: Item, _ id: Int) {
        print("id \(id)")
        if entity.completedItems != nil {
            if entity.completedItems!.contains(id){
                print("entity \(String(describing: entity.completedItems))")
            } else {
                entity.completedItems?.append(id)
            }
        }
        saveData()
        print("Saved Items \(String(describing: entity.completedItems))")
    }

    func saveUserNotes(_ entity: Item, _ userNote: String) {
        print("Current notes - \(entity.notes) - \(userNote)")
        entity.notes?.append(userNote)
        saveData()
        print("Notes: \(entity.notes)")
    }

    func getUserNotes(_ entity: Item, _ projectName: String) -> [String] {
        var notesArray: [String] = []
        notesArray = entity.notes ?? [""]
        print("returnNotes: \(notesArray)")
        return notesArray
    }

    func removeTask(_ entity: Item, _ id: Int) {
        print("id \(id)")
        if entity.completedItems != nil {
            if entity.completedItems!.contains(id){
                let index = entity.completedItems?.firstIndex(of: id) //find(entity.completedItems, id)
                entity.completedItems?.remove(at: index!)
                print("entity \(String(describing: entity.completedItems))")
            }
        }
        saveData()
        print("Saved Items \(String(describing: entity.completedItems))")
    }

    func getCompletedTasks(_ entity: Item, _ projectName: String) -> [Int] {
        var array: [Int] = []
        array = entity.completedItems ?? []
        return array
    }

    func generateProjectID() -> Int32 {
        var existingProjectID = 0
        var newProjectID = 0

        for entity in savedEntities {
            if entity.projectUID > newProjectID {
                newProjectID = Int(entity.projectUID)
                print("newProjectID \(newProjectID)")
            }
        }
        saveData()
        return Int32(newProjectID + 1)
    }

    func projectDuplicateNameCheck(name: String) -> Bool {
        var projectDuplicate = false

        for item in savedEntities {
            if name.lowercased() == item.projectName?.lowercased() {
                projectDuplicate = true
            } else {
                projectDuplicate = false
            }
        }
        return projectDuplicate
    }

}
