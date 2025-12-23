//
//  MainView.swift
//  MoniCrop
//
//  Created by Eman Sarah Afi on 12/23/25.
//

import SwiftUI
import Firebase

struct MainView: View {
    var body: some View {
        VStack(spacing: 50) {
            Image("MoniCrop")
                .frame(width: 50, height: 50)
                .padding(.bottom, 200)
            Text("Welcome")
                .foregroundColor(Color(red: 148/255, green: 178/255, blue: 2/255))
                .font(.title)
                .fontWeight(.bold)
            if let email = Auth.auth().currentUser?.email {
                Text("Logged in as \(email)").foregroundColor(Color(red: 148/255, green: 178/255, blue: 2/255))
                    .foregroundColor(Color.black)
                    .font(.system(size: 20))
            } else {
                Text("Not logged in").foregroundColor(Color(red: 148/255, green: 178/255, blue: 2/255))
                    .foregroundColor(Color.black)
                    .font(.system(size: 20))
            }
        }
        .padding()
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        VStack(spacing: 50) {
            Image("MoniCrop")
                .frame(width: 50, height: 50)
                .padding(.bottom, 200)
            Text("Welcome")
                .foregroundColor(Color(red: 148/255, green: 178/255, blue: 2/255))
                .font(.title)
                .fontWeight(.bold)
            Text("Not logged in")
                .foregroundColor(Color.black)
                .font(.system(size: 20))
        }
        .padding()
    }
}
