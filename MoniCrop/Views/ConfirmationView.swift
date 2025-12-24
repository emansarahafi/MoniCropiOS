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
                .foregroundColor(Color.accent)
                .imageScale(.large)
                .font(.system(.largeTitle))
                .padding()
            Text("Feedback Received!")
                .foregroundColor(Color.accent)
                .fontWeight(.bold)
                .titleStyle()
                .padding()
            .padding()
            Button(action: {
                // Action for Done button
            }, label: {
                NavigationLink(destination: HamburgerMenuView().navigationBarBackButtonHidden(true)) {
                    Text("Done")
                        .frame(maxWidth: .infinity)
                }
            }).primaryButtonStyle()
                .bodyStyle()
                .padding(.top)
                .accessibilityLabel("Done - return to menu")
                .accessibilityIdentifier("confirmationDoneButton")
                .accessibilityHint("Returns to the main menu")
        }
        .padding()
    }
}

struct ConfirmationView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            ConfirmationView()
        }
        .previewLayout(.sizeThatFits)
        .padding()
    }
}
