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
//                    if completedArray.contains(completedID) {
//                        Image(systemName: "checkmark")
//                    }
                    Text(title)
                        .foregroundColor(Color("FontColor"))
                        .padding()
                        .frame(maxWidth: .infinity)
                    Button(action: {
                        withAnimation {
                            showButtons.toggle()
                        }
                    }) {
                        Image(systemName: showButtons ? "chevron.down" : "chevron.right")
                            .foregroundColor(Color("FontColor"))
                            .padding(.trailing,8)
                    }
                    Spacer()
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
                                completed = true
                                showButtons = false
                                completedTaskModel.addItem(completedTask: completedID)
                            }
                        }) {
                            ButtonTextView(text: "Yes")
                        }
                        Button(action: {
                            withAnimation {
                                showInfo = true
                                showButtons = false
                                infoOverLayInfo.title = title
                                infoOverLayInfo.description = info
                                completed = false
                            }
                        }) {
                            ButtonTextView(text: "No")
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
                    .stroke(.secondary, lineWidth: 1)
            )
            .padding(.horizontal)
        }
    }
}

struct BeforeRowView_Previews: PreviewProvider {
    static var previews: some View {
        ProjectRowView(infoOverLayInfo: OverLayInfo(), showInfo: .constant(false), title: "Before Project", question: "Question", info: "info", completedID: 1)
        ProjectRowView(infoOverLayInfo: OverLayInfo(), showInfo: .constant(false), title: "Before Project", question: "Question", info: "info", completedID: 1)
            .colorScheme(.dark)
    }
}

class CompletedTasksModel: ObservableObject {

   @Published var completedItems = [Int]()

    func addItem(completedTask: Int){
        var array: [Int] = []
        array.append(completedTask)

//      Setting userDefaults
        let userDefaults = UserDefaults.standard
        userDefaults.set(array, forKey: "userDefault-completedItems")
//      Read userDefaults
        let userDefaultArray = userDefaults.array(forKey: "userDefault-completedItems") as? [Int] ?? [Int]()
        print("added items read from userdefaults \(userDefaultArray)")
        for item in userDefaultArray {
            print(item)
        }
   }

    func isCompletedTask(existingTask: Int) -> Bool {

        if completedItems.contains(existingTask) {
            return true
        } else {
            return false
        }
    }
}
