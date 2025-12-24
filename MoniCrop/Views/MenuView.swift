import SwiftUI
import Firebase

struct MenuView: View {
    @Environment(\.openURL) var openURL

    var body: some View {
        VStack(alignment: .leading, spacing: 18) {
            Text("Main Menu")
                .foregroundColor(Color.accent)
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding(.top, 24)

            VStack(alignment: .leading, spacing: 18) {
                NavigationLink(destination: ViewItemsView()) {
                    HStack {
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(Color.accent)
                        Text("View Items")
                            .foregroundColor(.black)
                            .font(.headline)
                    }
                }
                .accessibilityIdentifier("menuViewItems")
                .accessibilityLabel("View items")
                .accessibilityHint("Open the item browser")

                NavigationLink(destination: ViewDataView()) {
                    HStack {
                        Image(systemName: "chart.bar")
                            .foregroundColor(Color.accent)
                        Text("View Data")
                            .foregroundColor(.black)
                            .font(.headline)
                    }
                }
                .accessibilityIdentifier("menuViewData")
                .accessibilityLabel("View data")
                .accessibilityHint("Open charts and sensor data")

                NavigationLink(destination: WorkplaceDetailsView()) {
                    HStack {
                        Image(systemName: "book")
                            .foregroundColor(Color.accent)
                        Text("View Workplace Details")
                            .foregroundColor(.black)
                            .font(.headline)
                    }
                }
                .accessibilityIdentifier("menuWorkplaceDetails")
                .accessibilityLabel("Workplace details")
                .accessibilityHint("View details about your workplace")

                NavigationLink(destination: CustomerFeedbackView()) {
                    HStack {
                        Image(systemName: "face.smiling")
                            .foregroundColor(Color.accent)
                        Text("Customer Feedback")
                            .foregroundColor(.black)
                            .font(.headline)
                    }
                }
                .accessibilityIdentifier("menuCustomerFeedback")
                .accessibilityLabel("Customer feedback")
                .accessibilityHint("Provide feedback about the app")

                HStack {
                    Image(systemName: "square.and.arrow.down")
                        .foregroundColor(Color.accent)
                    Button("View PDF Brochure") {
                        openURL(URL(string: "https://www.canva.com/design/DAFOn23KpfE/Eueuve2e40uBRa0V7cRz9w/view?utm_content=DAFOn23KpfE&utm_campaign=designshare&utm_medium=link&utm_source=publishsharelink")!)
                    }
                    .foregroundColor(.black)
                    .font(.headline)
                    .accessibilityIdentifier("menuViewPDFBrochure")
                    .accessibilityLabel("View PDF brochure")
                    .accessibilityHint("Open a PDF brochure in your browser")
                }

                HStack {
                    Image(systemName: "square.and.arrow.up")
                        .foregroundColor(Color.accent)
                    Button("Access Telegram Channel") {
                        openURL(URL(string: "https://t.me/MoniCropFeedback")!)
                    }
                    .foregroundColor(.black)
                    .font(.headline)
                    .accessibilityIdentifier("menuAccessTelegram")
                    .accessibilityLabel("Access Telegram channel")
                    .accessibilityHint("Open MoniCrop's Telegram feedback channel")
                }

                NavigationLink(destination: FirstEditAccountView()) {
                    HStack {
                        Image(systemName: "person")
                            .foregroundColor(Color.accent)
                        Text("Edit Account")
                            .foregroundColor(.black)
                            .font(.headline)
                    }
                }
                .accessibilityIdentifier("menuEditAccount")
                .accessibilityLabel("Edit account")
                .accessibilityHint("Open account editing")

                HStack {
                    Image(systemName: "rectangle.portrait.and.arrow.right")
                        .foregroundColor(Color.accent)
                    Button(action: {
                        do {
                            try Auth.auth().signOut()
                            UserDefaults.standard.set(false, forKey: "status")
                            NotificationCenter.default.post(name: NSNotification.Name("status"), object: nil)
                        } catch {
                            print("Error signing out: \(error)")
                        }
                    }) {
                        Text("Sign Out")
                    }
                    .foregroundColor(.black)
                    .font(.headline)
                    .accessibilityIdentifier("menuSignOut")
                    .accessibilityLabel("Sign out")
                    .accessibilityHint("Sign out of the application")
                }
                .padding(.bottom, 24)
            }
            .padding(.bottom, 24)
            Spacer()
        }
        .padding(.horizontal)
        .background(Color(.systemBackground))
        .frame(maxHeight: .infinity, alignment: .top)
        // sign-out updates AppStorage("status") and switches root; no local navigation required
    }
}

struct MenuView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            MenuView()
        }
        .previewLayout(.sizeThatFits)
        .padding()
    }
}
