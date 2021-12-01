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
        TelemetryManager.send(
        "onboardZipCode",
        for: "zipCode user",
        with: ["zipCode": zipCode])
    }

    func sendScreen(screen: String){
        TelemetryManager.initialize(with: configuration)
        TelemetryManager.send(screen)
    }
    
    func sendCompletedProject(){
        TelemetryManager.initialize(with: configuration)
        TelemetryManager.send("Completed Onboard Info")
    }

    func sendProject(budget: String, project: String){
        TelemetryManager.initialize(with: configuration)
        TelemetryManager.send(
        "onboardInfoCompleted",
        for: "project & budget user",
        with: [
            "budget": budget,
            "project": project])
    }
}

