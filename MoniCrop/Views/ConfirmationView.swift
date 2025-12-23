//
//  ConfirmationView.swift
//  MoniCrop
//
//  Created by Eman Sarah Afi on 12/23/25.
//

import SwiftUI

struct ConfirmationView: View {

    var body: some View {
        VStack {
            Image(systemName: "checkmark")
                .foregroundColor(Color(red: 148/255, green: 178/255, blue: 2/255))
                .imageScale(.large)
                .font(.system(size: 120))
                .padding()
            Text("Feedback Received!")
                .foregroundColor(Color(red: 148/255, green: 178/255, blue: 2/255))
                .fontWeight(.bold)
                .font(.system(size: 50))
                .padding()
            .padding()
            Button(action: {
                // Action for Done button
            }, label: {
                NavigationLink(destination: HamburgerMenuView().navigationBarBackButtonHidden(true)) {
                    Text("Done")
                        .frame(maxWidth: .infinity)
                }
            }).buttonStyle(.borderedProminent)
                .tint(Color(red: 148/255, green: 178/255, blue: 2/255))
                .foregroundColor(.white)
                .font(.system(size: 20))
                .padding(.top)
        }
        .padding()
    }
}

struct ConfirmationView_Previews: PreviewProvider {
    static var previews: some View {
        ConfirmationView()
            .previewLayout(.sizeThatFits)
            .padding()
    }
}
