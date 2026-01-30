//
//  MainView.swift
//  MoniCrop
//
//  Created by Eman Sarah Afi on 1/7/26.
//

import SwiftUI

struct MainView: View {
    @EnvironmentObject var usersVM: UsersViewModel
    
    var body: some View {
        VStack(spacing: 50) {
            Image("MoniCrop")
                .frame(width: 50, height: 50)
                .padding(.bottom, 200)
            
            if let user = usersVM.currentUser {
                Text("Welcome, \(user.firstName)!")
                    .foregroundColor(Color(red: 148/255, green: 178/255, blue: 2/255))
                    .font(.title)
                    .fontWeight(.bold)
                
                Text("\(Text("Account Email: ").bold().foregroundColor(Color(red: 148/255, green: 178/255, blue: 2/255)))\(user.emailAccount)")
                    .foregroundColor(Color.black)
                    .font(.system(size: 20))
            } else {
                Text("Welcome")
                    .foregroundColor(Color(red: 148/255, green: 178/255, blue: 2/255))
                    .font(.title)
                    .fontWeight(.bold)
            }
        }
        .padding()
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
            .environmentObject(UsersViewModel())
    }
}
