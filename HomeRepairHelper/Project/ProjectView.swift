//
//  ProjectView.swift
//  HomeRepairHelper
//
//  Created by robevans on 1/12/22.
//

import SwiftUI
import TelemetryClient

struct ProjectView: View {
    @StateObject var projectData = ProjectData()
    
    @StateObject var coredataVM = CoreDataManager()
    @StateObject var telemtryData = TelemetryData()

    @AppStorage("UserDefault_FirstRun") var showFirstRun = true

    @State var showProjectView = false
    @State var showSettings = false
    @State var showAddProjectSheet = false

    var body: some View {
        NavigationView {
            ZStack {
                Color("Background")
                    .edgesIgnoringSafeArea(.all)
                VStack {
                    if coredataVM.savedEntities.count != 0 {
                        List {
                            ForEach(coredataVM.savedEntities) { entity in
                                ProjectListRowView(name: entity.projectName ?? "nil",
                                                   type: entity.projectType ?? "nil",
                                                   budget: entity.projectBudget ?? "nil")
                                    .onTapGesture {
                                        withAnimation {
                                            showProjectView = true
                                            projectData.projectName = entity.projectName ?? ""
                                            projectData.projectID = Int(entity.projectUID)
                                        }
                                    }
                            }
                            .onDelete(perform: coredataVM.deleteItem)
                        }
                    } else {
                        VStack {
                            Spacer()
                            HStack {
                                Text("No Projects Currently. Tap")
                                Image(systemName: "plus.diamond.fill")
                                Text("To Get Started.")
                            }
                            Spacer()
                        }
                    }
                }
                .listStyle(.inset)
                VStack {
                    Spacer()
                    HStack {
                        Spacer()
                        AddProjectButtonView(showAddProjectSheet: $showAddProjectSheet)
                    }
                }
                .padding(30)
                .fullScreenCover(isPresented: $showAddProjectSheet, onDismiss: {
                    coredataVM.fetchData()}, content: {
                    AddProjectView(showAddProjectSheet: $showAddProjectSheet)
                })
                .fullScreenCover(isPresented: $showProjectView, onDismiss: {
                    coredataVM.fetchData()}, content: {
                        TabBar(projectData: projectData, showProjectView: $showProjectView)
                })
                .sheet(isPresented: $showSettings) {
                    Settings()
                }
            }
            .onAppear {
                print("core \(coredataVM.savedEntities.count)")
            }
            .navigationBarTitle("Current Projects")
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button(action: {
                        playHaptic(style: "medium")
                        showSettings = true
                        telemtryData.sendScreen(screen: "showSettings")
                    }) {
                        Image(systemName: "gearshape.fill")
                    }
                }
            }
            .fullScreenCover(isPresented: $showFirstRun,
                onDismiss: { print("dismissed!") },
                             content: { ProjectOnboardView(showProjectSheet: .constant(false)) })
        }
    }
}

struct ProjectView_Previews: PreviewProvider {
    static var previews: some View {
        ProjectView(projectData: ProjectData())
        ProjectListRowView(name: "Project Name", type: "Remodel", budget: "millions")
    }
}

struct ProjectListRowView: View {
    let name: String
    let type: String
    let budget: String

    var body: some View {
        VStack(alignment: .leading) {
            Text(name)
                .bold()
                .font(.title2)
            HStack {
                HStack {
                    Image(systemName: "\(getBudgetImage(type))")
                        .foregroundColor(.secondary)
                    Text(type)
                        .font(.callout)
                    .foregroundColor(.secondary)
                }
                Spacer()
                HStack {
                    Image(systemName: "dollarsign.circle")
                        .foregroundColor(.secondary)
                    Text(budget)
                        .font(.callout)
                    .foregroundColor(.secondary)
                }
            }
            .padding(.top, 5)
            .padding(.horizontal, 5)
        }
        .padding()
    }
}


struct AddProjectButtonView: View {
    @Binding var showAddProjectSheet: Bool

    var body: some View {
        ZStack(alignment: .bottom) {
            Button(action: {
                showAddProjectSheet = true
                playHaptic(style: "medium")
            }) {
                Image(systemName: "plus.diamond.fill")
                    .font(.largeTitle)
            }
        }
    }
}

func getBudgetImage(_ type: String) -> String {

    switch type {

    case "fire":
        return "flame"
    case "Flood":
        return "drop"
    case "Tornado/Storm":
     return "tornado"
    case "Hurricane":
        return "hurricane"
    case "Emergency Repair":
        return "exclamationmark.octagon"
    case "Non-Emergency Repair":
        return "hammer"
    case "Remodel/Improvement":
        return "house"
    case "Other":
        return "square.grid.2x2"
    default:
        return "hammer.fill"
    }
}
