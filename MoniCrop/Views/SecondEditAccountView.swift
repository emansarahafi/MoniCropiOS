//
//  SecondEditAccountView.swift
//  MoniCrop
//
//  Created by Eman Sarah Afi on 12/23/25.
//

import SwiftUI
import Firebase

struct SecondEditAccountView: View {
    var onComplete: ((EditAction) -> Void)? = nil
    @Environment(\.dismiss) private var dismiss
    @State var date = Date()
    @State var fname: String = ""
    @State var mname: String = ""
    @State var lname: String = ""
    @State var wname: String = ""
    @State var position: String = ""
    @State var isLoading: Bool = false
    @State var showError: Bool = false
    @State var errorMessage: String = ""
    @State private var showSuccess = false
    @State private var showFailure = false
    @State private var failureMessage = ""

    var body: some View {
        VStack {
            Group {
                Text("First Name")
                    .bodyStyle()
                TextField("Insert First Name", text: $fname) .textFieldStyle(.roundedBorder) .textInputAutocapitalization(.words)
                    .bodyStyle()
                Text("Middle Name")
                    .bodyStyle()
                TextField("Insert Middle Name", text: $mname) .textFieldStyle(.roundedBorder) .textInputAutocapitalization(.words)
                    .bodyStyle()
                Text("Last Name")
                    .bodyStyle()
                TextField("Insert Last Name", text: $lname) .textFieldStyle(.roundedBorder) .textInputAutocapitalization(.words)
                    .bodyStyle()
            }
            DatePicker("Date of Birth",
                        selection: $date,
                        in: ...Date(),
                        displayedComponents: [.date])
            .bodyStyle()
                        .padding()
            Text("Workplace Name")
                .bodyStyle()
            TextField("Insert Workplace Name", text: $wname) .textFieldStyle(.roundedBorder) .textInputAutocapitalization(.words)
                .bodyStyle()
            Text("Position")
                .bodyStyle()
            TextField("Insert Position", text: $position) .textFieldStyle(.roundedBorder) .textInputAutocapitalization(.words)
                .bodyStyle()

            if showError {
                Text(errorMessage)
                    .foregroundColor(.red)
                    .font(.footnote)
                    .padding(.top, 5)
            }

            Button {
                updateAccount()
            } label: {
                Text("Update Account")
                    .frame(maxWidth: .infinity)
            }
            .primaryButtonStyle()
            .bodyStyle()
            .padding(.top)
            .accessibilityIdentifier("updateAccountButton")
            .accessibilityLabel("Update account")
            .accessibilityHint("Saves your account changes and returns to the menu")
            .alert("Success", isPresented: $showSuccess) {
                Button("Continue") {
                    dismiss()
                }
            } message: {
                Text("Account updated successfully.")
            }
            .alert("Error", isPresented: $showFailure) {
                Button("OK") {}
            } message: {
                Text(self.failureMessage)
            }
            NavigationLink(destination: DisableDeleteView()) {
                Text("Disable or Delete Your Account")
            }
            .foregroundColor(Color.accent)
            .bodyStyle()
            .padding(.top)
            .accessibilityIdentifier("disableDeleteAccountButton")
            .accessibilityLabel("Disable or delete account")
            .accessibilityHint("Choose to disable or delete your account")
        }
        .padding()
    }

    private func updateAccount() {
        // Reset error state
        showError = false
        errorMessage = ""

        // Validate required fields
        guard !fname.isEmpty else {
            failureMessage = "First name is required"
            showFailure = true
            return
        }

        guard !lname.isEmpty else {
            failureMessage = "Last name is required"
            showFailure = true
            return
        }

        guard !wname.isEmpty else {
            failureMessage = "Workplace name is required"
            showFailure = true
            return
        }

        guard !position.isEmpty else {
            failureMessage = "Position is required"
            showFailure = true
            return
        }

        guard let user = Auth.auth().currentUser else {
            failureMessage = "No user is currently signed in"
            showFailure = true
            return
        }

        isLoading = true

        let db = Firestore.firestore()
        let userRef = db.collection("users").document(user.uid)

        userRef.setData([
            "firstName": fname,
            "middleName": mname,
            "lastName": lname,
            "dob": date,
            "workplaceName": wname,
            "position": position
        ], merge: true) { error in
            isLoading = false
            if let error = error {
                failureMessage = "Error updating account: \(error.localizedDescription)"
                showFailure = true
            } else {
                DispatchQueue.main.async {
                    showSuccess = true
                }
            }
        }
    }
}

struct SecondEditAccountView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            SecondEditAccountView()
        }
        .previewLayout(.sizeThatFits)
        .padding()
    }
}
