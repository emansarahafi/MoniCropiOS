//
//  ConfirmationView.swift
//  MoniCrop
//
//  Created by Eman Sarah Afi on 12/23/25.
//

import SwiftUI

struct ConfirmationView: View {
    @Environment(\.dismiss) private var dismiss

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
            Button {
                dismiss()
            } label: {
                Text("Done")
                    .frame(maxWidth: .infinity)
            }
            .primaryButtonStyle()
            .bodyStyle()
            .padding(.top)
            .accessibilityLabel("Done - return to menu")
            .accessibilityIdentifier("confirmationDoneButton")
            .accessibilityHint("Returns to the feedback form")
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
