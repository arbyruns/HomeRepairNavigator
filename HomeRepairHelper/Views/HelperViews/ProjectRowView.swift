//
//  BeforeRowView.swift
//  HomeRepairNavigator
//
//  Created by robevans on 11/15/21.
//

import SwiftUI


struct ProjectRowView: View {
    @AppStorage("UserDefault_CompleteTasks") var useCompletedTasks = false
    @StateObject var coredataVM = CoreDataManager()
    @ObservedObject var projectData: ProjectData

    @ObservedObject var infoOverLayInfo: OverLayInfo
    @ObservedObject var completedTaskModel = CompletedTasksModel()

    @State var showButtons = false
    @State var completed = false
    @State var trimVal: CGFloat = 0

    @Binding var showInfo: Bool
    @Binding var showSheet: Bool
    @Binding var showCompletedSheet: Bool
    
    let title: String
    let question: String
    let info: String
    let completedID: Int
    //    let showCheckmark: Bool

    @State var coreCompletedItems: [Int] = []
    
    var body: some View {
        ZStack {
            Color("Background")
                .edgesIgnoringSafeArea(.all)
            VStack {
                HStack {
                    if coreCompletedItems.contains(completedID)  && useCompletedTasks == false {
                        CheckMarkView(checked: .constant(true), trimValue: .constant(1))
                            .padding(.leading)
                    }
                    if coreCompletedItems.contains(completedID)  && useCompletedTasks == true {
                        SquareCompletionView(checked: .constant(true), trimValue: .constant(1))
                            .padding(.leading)
                    }
                    Text(LocalizedStringKey(title))
                        .strikethrough(coreCompletedItems.contains(completedID) ? true : false)
                        .foregroundColor(coreCompletedItems.contains(completedID) ? .gray : Color("FontColor"))
                        .font(.callout)
                        .padding()
                    Spacer()
                    Button(action: {
                        withAnimation {
                            playHaptic(style: "light")
                            showButtons.toggle()
                        }
                    }) {
                        Image(systemName: showButtons ? "chevron.down" : "chevron.right")
                            .foregroundColor(Color("FontColor"))
                            .padding(.trailing,8)
                    }
//                    Spacer()
                }
                .onTapGesture {
                    withAnimation {
                        showButtons.toggle()
                    }
                }
                if showButtons {
                    HStack {
                        Button(action: {
                            playHaptic(style: "medium")
                            withAnimation {
                                self.trimVal = 1
                                completed = true
                                showButtons = false
                                for entity in coredataVM.savedEntities {
                                    if entity.projectName == projectData.projectName {
                                        coredataVM.saveTask(entity, completedID)
                                        coreCompletedItems = coredataVM.getCompletedTasks(entity, projectData.projectName)
                                    }
                                }
                                if completedID == 30 {
                                    showCompletedSheet = true
                                    showSheet = true
                                }
                            }
                        }) {
                            ButtonTextView(smallButton: true, text: "Yes")
                        }
                        Button(action: {
                            playHaptic(style: "medium")
                            withAnimation {
                                self.trimVal = 0
                                showInfo = true
                                showButtons = false
                                showSheet = true
                                infoOverLayInfo.title = title
                                infoOverLayInfo.description = info
                                completed = false
                                for entity in coredataVM.savedEntities {
                                    if entity.projectName == projectData.projectName {
                                        coredataVM.removeTask(entity, completedID)
                                        coreCompletedItems = coredataVM.getCompletedTasks(entity, projectData.projectName)
                                    }
                                }
//                                completedTaskModel.removeItem(completedTask: completedID)
                            }
                        }) {
                            ButtonTextView(smallButton: true, text: "No")
                        }
                    }
                    .padding()
                }
            }
            .overlay(
                RoundedRectangle(cornerRadius: 8)
                    .stroke(Color("borderColor"), lineWidth: 1)
            )
            .padding(.horizontal)
            .onAppear {
                for entity in coredataVM.savedEntities {
                    if entity.projectName == projectData.projectName {
                        coreCompletedItems = coredataVM.getCompletedTasks(entity, projectData.projectName)
                        print("Completed items \(coreCompletedItems) - \(projectData.projectName)")
                    }
                }
            }
        }
    }
}

struct BeforeRowView_Previews: PreviewProvider {
    static var previews: some View {
        ProjectRowView(projectData: ProjectData(), infoOverLayInfo: OverLayInfo(), showInfo: .constant(false), showSheet: .constant(false), showCompletedSheet: .constant(false), title: "Have you researched the project", question: "Question", info: "info", completedID: 1)
        ProjectRowView(projectData: ProjectData(), infoOverLayInfo: OverLayInfo(), showInfo: .constant(false), showSheet: .constant(false), showCompletedSheet: .constant(false), title: "Have you researched the project", question: "Question", info: "info", completedID: 1)
            .colorScheme(.dark)
    }
}


class CompletedTasksModel: ObservableObject {

    @Published var completedItems = [Int]()

    private let kUserDefaultsCompletedItems = "userDefault-completedItems"


    /// adds trackingID for completed items to default settings array
    /// - Parameter completedTask: Takes trackingID for tracking of completed tasks
    func addItem(completedTask: Int){
        let userDefaults = UserDefaults.standard

        var array: [Int] = userDefaults.array(forKey: kUserDefaultsCompletedItems) as? [Int] ?? []
        if array.contains(completedTask) {
            print("Completed Task already completed")
        } else {
            array.append(completedTask)
        }
        //      Setting userDefaults
        userDefaults.set(array, forKey: kUserDefaultsCompletedItems)
        //      Read userDefaults
        let userDefaultArray = userDefaults.array(forKey: kUserDefaultsCompletedItems) as? [Int] ?? []
        print("added items read from userdefaults \(userDefaultArray)")
    }

    /// removes trackingID  for completed items to default settings array
    /// - Parameter completedTask: <#completedTask description#>
    func removeItem(completedTask: Int) {
        let userDefaults = UserDefaults.standard
        var array: [Int] = userDefaults.array(forKey: kUserDefaultsCompletedItems) as? [Int] ?? []

        if array.contains(completedTask) {
            print("removeItem remove task \(completedTask)")
            if let index = array.firstIndex(of: completedTask) {
                array.remove(at: index)
            }
        }
        userDefaults.set(array, forKey: kUserDefaultsCompletedItems)

    }
    /// Determines if trackingID has been added and returns a bool value
    /// - Parameter isCompletedTask: Takes trackingID for tracking of completed tasks
    func isCompletedTask(completedTask: Int) -> Bool {
        let userDefaults = UserDefaults.standard
        var array: [Int] = userDefaults.array(forKey: kUserDefaultsCompletedItems) as? [Int] ?? []

        if array.contains(completedTask) {
            return true
        } else {
            return false
        }
    }
    /// Clears the userDefault array to nil
    func clearCompletedItems() {
        let userDefaults = UserDefaults.standard
        var array: [Int] = []
        userDefaults.set(array, forKey: kUserDefaultsCompletedItems)
    }
}
