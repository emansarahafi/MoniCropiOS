//
//  ContentView.swift
//  MoniCrop
//
//  Created by Eman Sarah Afi on 1/30/26.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var appData: ApplicationData
    @EnvironmentObject var usersVM: UsersViewModel
    
    var body: some View {
        if usersVM.isLoggedIn {
            HamburgerMenuView()
                .navigationBarBackButtonHidden(true)
        } else {
            LandingView()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(ApplicationData())
            .environmentObject(UsersViewModel())
    }
}
