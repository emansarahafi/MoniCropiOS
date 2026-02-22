//  ConfirmationView.swift
//  MoniCrop
//
//  Created by Eman Sarah Afi on 1/7/26.
//

import SwiftUI

struct ConfirmationView: View {
    @Environment(\.dismiss) private var dismiss
    var message: String = "Feedback Received!"
    var subtitle: String = "Thank you for your feedback. Your submission has been saved locally."

    var body: some View {
        VStack {
            Image(systemName: "checkmark")
                .foregroundColor(Color(red: 148/255, green: 178/255, blue: 2/255))
                .imageScale(.large)
                .font(.system(size: 120))
                .padding()
            Text(message)
                .foregroundColor(Color(red: 148/255, green: 178/255, blue: 2/255))
                .fontWeight(.bold)
                .font(.system(size: 50))
                .padding()
            Text(subtitle)
                .foregroundColor(.gray)
                .font(.system(size: 16))
                .multilineTextAlignment(.center)
                .padding(.horizontal)
            Button {
                dismiss()
            } label: {
                Text("Done")
                    .frame(maxWidth: .infinity)
            }
            .buttonStyle(.borderedProminent)
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
    }
}