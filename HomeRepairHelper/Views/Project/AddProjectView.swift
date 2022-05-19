//
//  AddProjectView.swift
//  HomeRepairHelper
//
//  Created by robevans on 1/12/22.
//

import SwiftUI
import TelemetryClient

struct AddProjectView: View {
    @StateObject var coredataVM = CoreDataManager()
    @StateObject var telemtryData = TelemetryData()

    @State var projectNameCheck = ""
    @State var projectName = ""
    @State var projectType = ""
    @State var userBudget = ""
    @State var projectZip = ""

    @Binding var showAddProjectSheet: Bool

    let budgetInfo = ["-", "0 - 5,000", "5,001 - 10,000", "10,001 - 25,000", "25,001 - 50,000", "50,001 - or more"]
    let projectInfo = ["-", "Fire", "Flood", "Tornado/Storm", "Hurricane", "Emergency Repair", "Non-Emergency Repair", "Remodel/Improvement", "Other"]

    var body: some View {
        NavigationView {
            ZStack {
                Color("Background")
                    .edgesIgnoringSafeArea(.all)
                VStack {
                    VStack(alignment: .leading) {
                        Text("Project Name:")
                            .font(.title2)
                            .bold()
                        HStack {
                            TextField("My Home Repair ", text: $projectName)
                            if coredataVM.projectDuplicateNameCheck(name: projectName) {
                                Image(systemName: "xmark")
                                    .foregroundColor(.red)
                            } else {
                                if projectName.count > 1 {
                                    Button(action: {
                                        playHaptic(style: "medium")
                                        withAnimation {
                                            projectName = ""
                                        }
                                    })// swiftlint:disable multiple_closures_with_trailing_closure
                                    { Image(systemName: "checkmark")
                                            .foregroundColor(.red)
                                    }
                                    .buttonStyle(PlainButtonStyle())
                                }
                            }
                        }
                        if coredataVM.projectDuplicateNameCheck(name: projectName) {
                        Text("*Project name already exists*")
                            .font(.caption)
                            .foregroundColor(.secondary)
                            .padding(.top)
                        }
                    }
                    .padding()
                    HStack {
                        Text("Project Type:")
                            .font(.title2)
                            .bold()
                        Spacer()
                        Picker(projectType, selection: $projectType) {
                            ForEach(projectInfo, id: \.self) {
                                Text("\($0)")
                                    .font(.subheadline)
                                    .bold()
                            }
                        }
                        .pickerStyle(.menu)
                    }
                    .padding()
                    HStack {
                        Text("Project Budget:")
                            .font(.title2)
                            .bold()
                        Spacer()
                        Picker("Project Budget", selection: $userBudget) {
                            ForEach(budgetInfo, id: \.self) {
                                Text("\($0)")
                                    .font(.subheadline)
                            }
                        }
                        .pickerStyle(.menu)
                    }
                    .padding()
                    VStack(alignment: .leading) {
                        Text("Zip Code:")
                            .font(.title2)
                            .bold()
                        HStack {
                        TextField("5 digit zipcode", text: $projectZip)
                            .keyboardType(.numberPad)
                                if checkZipCode(projectZip) {
                                    withAnimation {
                                    Image(systemName: "checkmark")
                                            .foregroundColor(.green)
                                    }
                                }
                        }
                        Text("*Our app is free for you. To keep it that way, we just need some general information so our donors can see where we are making an impact. This information is anonymized and does not link back to you as the user.*")
                            .font(.caption)
                            .padding(.top)
                    }
                    .padding()
                    .navigationBarTitle("Add A New Project")
                    .toolbar {
                        ToolbarItem(placement: .cancellationAction) {
                            Button(action: {
                                playHaptic(style: "light")
                                showAddProjectSheet = false
                                telemtryData.sendScreen(screen: "AddProjectCancel")
                            }) {
                                Text("Cancel")
                            }
                        }
                        ToolbarItem(placement: .primaryAction) {
                            Button(action: {
                                playHaptic(style: "medium")
                                print("\(projectType) - \(userBudget)")
                                coredataVM.saveProject(projectName: projectName,
                                                       projectBudget: userBudget,
                                                       ProjectType: projectType,
                                                       projectZip: Int(projectZip) ?? 00000)

                                showAddProjectSheet = false
                                projectName = ""
                                projectZip = ""
                                telemtryData.sendProject(budget: userBudget, project: projectType, zipCode: projectZip)
                            }) {
                                Text("Save")
                            }
                            .disabled(checkZipCode(projectZip) ? false : true)
                        }
                    }
                    Spacer()
                }
                .padding(.top)
            }
        }
    }
}

struct AddProjectView_Previews: PreviewProvider {
    static var previews: some View {
        AddProjectView(showAddProjectSheet: .constant(false))
    }
}

func checkZipCode(_ zipCode: String) -> Bool {

    if zipCode.isEmpty || zipCode.count < 5 {
        return false
    } else {
        return true
    }
}
