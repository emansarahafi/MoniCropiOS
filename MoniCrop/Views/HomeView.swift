//
//  HomeView.swift
//  MoniCrop
//
//  Created by Eman Sarah Afi on 1/30/23.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject var usersVM: UsersViewModel

    var body: some View {
        HamburgerMenuView()
            .onAppear {
                usersVM.loadCurrentUser()
            }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        // Show landing state for preview to avoid reading app state
        LandingView()
    }
}
