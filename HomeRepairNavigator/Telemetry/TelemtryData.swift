//
//  TelemtryData.swift
//  HomeRepairNavigator
//
//  Created by robevans on 11/22/21.
//

import Foundation
import TelemetryClient

class TelemetryData: ObservableObject {

    let configuration = TelemetryManagerConfiguration(appID: "F04097E4-3ECD-42D8-A343-92F46D03EEC9")

    func sendLaunchTelemtry(){
        TelemetryManager.initialize(with: configuration)
        TelemetryManager.send("applicationDidFinishLaunching")
    }
    
    func sendZipCode(zipCode: String) {
        TelemetryManager.initialize(with: configuration)
        TelemetryManager.send(zipCode)
    }

    func sendProject(project: String){
        TelemetryManager.initialize(with: configuration)
        TelemetryManager.send(project)
    }

    func sendBudget(budget: String){
        TelemetryManager.initialize(with: configuration)
        TelemetryManager.send(budget)
    }

    func sendScreen(screen: String){
        TelemetryManager.initialize(with: configuration)
        TelemetryManager.send(screen)
    }

    func sendMeta(){
        TelemetryManager.initialize(with: configuration)
        TelemetryManager.send(
        "applicationDidFinishLaunching",
        for: "my very cool user",
        with: [
            "numberOfTimesPizzaModeHasActivated": "1",
            "pizzaCheeseMode": "true"])
    }
}

