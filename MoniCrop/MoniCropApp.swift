//
//  MoniCropApp.swift
//  MoniCrop
//
//  Created by Eman Sarah Afi on 12/2/22.
//

import SwiftUI

@main
struct MoniCropApp: App {
    @StateObject var appData = ApplicationData()
    @StateObject var usersVM = UsersViewModel()
    @StateObject var feedbacksVM = FeedbacksViewModel()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(appData)
                .environmentObject(usersVM)
                .environmentObject(feedbacksVM)
                .onAppear {
                    // Restore user session if exists
                    usersVM.restoreUser(from: appData.userData)
                }
        }
    }
}
