//
//  CustomerFeedbackView.swift
//  MoniCrop
//
//  Created by Eman Sarah Afi on 1/7/23.
//

import SwiftUI
import Firebase
import FirebaseAuth
import FirebaseFirestore

struct CustomerFeedbackView: View {
    @State private var email: String = ""
    @State private var message: String = ""
    @State private var showError = false
    @State private var errorMessage = ""
    @State private var navigateToConfirmation = false

    var body: some View {
        VStack {
                Image("MoniCrop")
                    .accessibilityHidden(true)
                .frame(width: 50, height: 50)
                .padding(.bottom, 150)
            Text("Customer Feedback")
                .foregroundColor(Color.accent)
                .titleStyle()
                .padding()
            VStack(alignment: .leading) {
                Text("Email Address")
                    .bodyStyle()
                TextField("Insert Email", text: $email)
                    .keyboardType(.emailAddress)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .textContentType(.emailAddress)
                    .textInputAutocapitalization(.never)
                    .autocorrectionDisabled(true)
                    .accessibilityLabel("Feedback email address")
                    .accessibilityIdentifier("feedbackEmailField")
            }
            VStack (alignment: .leading) {
                Text("Feedback or Complaint")
                    .bodyStyle()
                TextField("Insert Feedback", text: $message)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .textContentType(.none)
                    .autocorrectionDisabled(true)
                    .accessibilityLabel("Feedback text")
                    .accessibilityIdentifier("feedbackTextField")
            }
            Button(action: {
                submitFeedback()
            }, label: {
                Text("Submit")
                    .frame(maxWidth: .infinity)
            })
            .primaryButtonStyle()
            .bodyStyle()
            .padding(.top)
            .accessibilityIdentifier("submitFeedbackButton")
            .accessibilityLabel("Submit feedback")
            .accessibilityHint("Submit your feedback and proceed to confirmation")
            .alert("Error", isPresented: $showError) {
                Button("OK") {}
            } message: {
                Text(errorMessage)
            }
            .navigationDestination(isPresented: $navigateToConfirmation) {
                ConfirmationView().navigationBarBackButtonHidden(true)
            }
        }
        .padding()
    }
    private func submitFeedback() {
        // Validate email
        guard !email.isEmpty else {
            errorMessage = "Email is required"
            showError = true
            return
        }
        
        guard isValidEmail(email) else {
            errorMessage = "Please enter a valid email address"
            showError = true
            return
        }
        
        guard !message.isEmpty else {
            errorMessage = "Feedback is required"
            showError = true
            return
        }
        
        guard let userId = Auth.auth().currentUser?.uid else {
            errorMessage = "You must be signed in to submit feedback"
            showError = true
            return
        }
        
        let feedback = Feedback(email: email, message: message, timestamp: Date())

        // Send feedback to Telegram channel using Config
        let telegramMessage = "User \(userId) submitted feedback: \(feedback.email) says: \(feedback.message)"
        if let encodedMessage = telegramMessage.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
           let telegramURL = URL(string: "https://api.telegram.org/bot\(Config.telegramBotToken)/sendMessage?chat_id=\(Config.telegramChatID)&text=\(encodedMessage)") {
            URLSession.shared.dataTask(with: telegramURL).resume()
        }

        // Write feedback to Firestore with unique document ID
        Firestore.firestore().collection("feedback").addDocument(data: [
            "userId": userId,
            "email": feedback.email,
            "message": feedback.message,
            "timestamp": Timestamp(date: feedback.timestamp)
        ]) { error in
            if let error = error {
                print("Error writing document: \(error)")
            } else {
                print("Feedback successfully written to Firestore")
            }
        }
        
        // Clear feedback text and navigate to confirmation
        email = ""
        message = ""
        navigateToConfirmation = true
    }
    
    private func isValidEmail(_ email: String) -> Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        return emailPredicate.evaluate(with: email)
    }
}

struct CustomerFeedbackView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            CustomerFeedbackView()
        }
        .previewLayout(.sizeThatFits)
        .padding()
    }
}
