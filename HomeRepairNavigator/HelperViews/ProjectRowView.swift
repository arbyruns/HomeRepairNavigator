//
//  BeforeRowView.swift
//  HomeRepairNavigator
//
//  Created by robevans on 11/15/21.
//

import SwiftUI


struct ProjectRowView: View {
    @ObservedObject var infoOverLayInfo: OverLayInfo
    @ObservedObject var completedTaskModel = CompletedTasksModel()

    @State var showButtons = false
    @State var completed = false
    @State var trimVal: CGFloat = 0

    @Binding var showInfo: Bool
    
    let title: String
    let question: String
    let info: String
    let completedID: Int
    //    let showCheckmark: Bool
    
    var body: some View {
        ZStack {
            Color("Background")
                .edgesIgnoringSafeArea(.all)
            VStack {
                HStack {
                    if completedTaskModel.isCompletedTask(completedTask: completedID) {
                        CheckMarkView(checked: .constant(true), trimValue: .constant(1))
                            .padding(.leading)
                    }
                    Text(title)
                        .strikethrough(completedTaskModel.isCompletedTask(completedTask: completedID) ? true : false)
                        .foregroundColor(completedTaskModel.isCompletedTask(completedTask: completedID)  ? .gray : Color("FontColor"))
                        .padding()
                    Spacer()
                    Button(action: {
                        withAnimation {
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
                            withAnimation {
                                self.trimVal = 1
                                completed = true
                                showButtons = false
                                completedTaskModel.addItem(completedTask: completedID)
                            }
                        }) {
                            ButtonTextView(smallButton: true, text: "Yes")
                        }
                        Button(action: {
                            withAnimation {
                                self.trimVal = 0
                                showInfo = true
                                showButtons = false
                                infoOverLayInfo.title = title
                                infoOverLayInfo.description = info
                                completed = false
                                completedTaskModel.removeItem(completedTask: completedID)
                            }
                        }) {
                            ButtonTextView(smallButton: true, text: "No")
                        }
                        //Unsure what Don't know should do.
                        //                        Button(action: {
                        //                            withAnimation {
                        //                            completed = false
                        //                            }
                        //                        }) {
                        //                            ButtonTextView(text: "Don't Know")
                        //                        }
                    }
                    .padding()
                }
            }
            .overlay(
                RoundedRectangle(cornerRadius: 8)
                    .stroke(Color("borderColor"), lineWidth: 1)
            )
            .padding(.horizontal)
        }
    }
}

struct BeforeRowView_Previews: PreviewProvider {
    static var previews: some View {
        ProjectRowView(infoOverLayInfo: OverLayInfo(), showInfo: .constant(false), title: "Have you researched the project", question: "Question", info: "info", completedID: 1)
        ProjectRowView(infoOverLayInfo: OverLayInfo(), showInfo: .constant(false), title: "Have you researched the project", question: "Question", info: "info", completedID: 1)
            .colorScheme(.dark)
    }
}

class CompletedTasksModel: ObservableObject {

    @Published var completedItems = [Int]()

    private let kUserDefaultsCompletedItems = "userDefault-completedItems"


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

    func isCompletedTask(completedTask: Int) -> Bool {
        let userDefaults = UserDefaults.standard
        var array: [Int] = userDefaults.array(forKey: kUserDefaultsCompletedItems) as? [Int] ?? []

        if array.contains(completedTask) {
            return true
        } else {
            return false
        }
    }
}
