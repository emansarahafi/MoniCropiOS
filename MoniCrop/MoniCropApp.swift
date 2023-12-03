//
//  MoniCropApp.swift
//  MoniCrop
//
//  Created by Eman Sarah Afi on 12/2/22.
//

import SwiftUI

@main
struct MoniCropApp: App {
    @StateObject var appData =  ApplicationData()
    var body: some Scene {
        WindowGroup {
            LandingPage().environmentObject(appData)
        }
    }
}
