//
//  CustomerView.swift
//  MoniCrop
//
//  Created by Eman Sarah Afi on 1/7/23.
//

import Foundation
import SwiftUI
import Firebase
import FirebaseAuth
import FirebaseFirestore

struct CustomerFeedbackView: View {
    @State private var email: String = ""
    @State private var opinion: String = ""

    var body: some View {
        VStack {
            Image("MoniCrop")
                .frame(width: 50, height: 50)
                .padding(.bottom, 150)
            Text("Customer Feedback")
                .foregroundColor(Color(red: 148/255, green: 178/255, blue: 2/255))
                .font(.title)
                .fontWeight(.bold)
                .padding()
            VStack(alignment: .leading) {
                Text("Email Address")
                    .font(.system(size: 20))
                TextField("Insert Email", text: $email)
                    .keyboardType(.emailAddress).textFieldStyle(RoundedBorderTextFieldStyle()) .textContentType(.emailAddress)
            }
            VStack (alignment: .leading) {
                Text("Feedback or Complaint")
                    .font(.system(size: 20))
                TextField("Insert Opinion", text: $opinion) .textFieldStyle(RoundedBorderTextFieldStyle()) .textContentType(.none)
            }
            Button(action: {
                submitFeedback()
            }, label: {
                NavigationLink(destination: ConfirmationView().navigationBarBackButtonHidden(true)) {
                    Text("Submit")
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
    private func submitFeedback() {
        // Validate email
        guard !email.isEmpty else {
            print("Email is required")
            return
        }
        
        guard isValidEmail(email) else {
            print("Please enter a valid email address")
            return
        }
        
        guard !opinion.isEmpty else {
            print("Feedback is required")
            return
        }
        
        guard let userId = Auth.auth().currentUser?.uid else {
            print("User not authenticated")
            return
        }
        
        let feedbackText = "\(email) says: \(opinion)"
        
        // Send feedback to Telegram channel using Config
        let telegramMessage = "User \(userId) submitted feedback: \(feedbackText)"
        
        // Send message to Telegram
        if let encodedMessage = telegramMessage.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
           let telegramURL = URL(string: "https://api.telegram.org/bot\(Config.telegramBotToken)/sendMessage?chat_id=\(Config.telegramChatID)&text=\(encodedMessage)") {
            URLSession.shared.dataTask(with: telegramURL).resume()
        }
        
        // Write feedback to Firestore
        let db = Firestore.firestore()
        db.collection("feedback").document(userId).setData([
            "email": email,
            "opinion": opinion
        ]) { error in
            if let error = error {
                print("Error writing document: \(error)")
            } else {
                print("Feedback successfully written to Firestore")
            }
        }
        
        // Clear feedback text
        email = ""
        opinion = ""
    }
    
    private func isValidEmail(_ email: String) -> Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        return emailPredicate.evaluate(with: email)
    }
}




struct CustomerView_Previews: PreviewProvider {
    static var previews: some View {
        CustomerFeedbackView()
    }
}
