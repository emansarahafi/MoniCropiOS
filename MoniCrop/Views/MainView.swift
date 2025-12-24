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
                .accessibilityHidden(true)
                .frame(width: 50, height: 50)
                .padding(.bottom, 200)
            Text("Welcome")
                .foregroundColor(Color.accent)
                .titleStyle()
                .fontWeight(.bold)
            if let email = Auth.auth().currentUser?.email {
                Text("Logged in as \(email)").foregroundColor(Color.accent)
                    .foregroundColor(Color.black)
                    .bodyStyle()
            } else {
                Text("Not logged in").foregroundColor(Color.accent)
                    .foregroundColor(Color.black)
                    .bodyStyle()
            }
        }
        .padding()
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            VStack(spacing: 50) {
                Image("MoniCrop")
                    .accessibilityHidden(true)
                    .frame(width: 50, height: 50)
                    .padding(.bottom, 200)
                Text("Welcome")
                    .foregroundColor(Color.accent)
                    .titleStyle()
                    .fontWeight(.bold)
                Text("Not logged in")
                    .foregroundColor(Color.black)
                    .bodyStyle()
            }
            .padding()
        }
        .previewLayout(.sizeThatFits)
        .padding()
    }
}
