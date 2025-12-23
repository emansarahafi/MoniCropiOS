import SwiftUI
import Firebase

struct MenuView: View {
    @Environment(\.openURL) var openURL

    var body: some View {
        VStack(alignment: .leading, spacing: 18) {
            Text("Main Menu")
                .foregroundColor(Color(red: 148/255, green: 178/255, blue: 2/255))
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding(.top, 24)

            VStack(alignment: .leading, spacing: 18) {
                NavigationLink(destination: ViewItemsView()) {
                    HStack {
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(Color(red: 148/255, green: 178/255, blue: 2/255))
                        Text("View Items")
                            .foregroundColor(.black)
                            .font(.headline)
                    }
                }

                NavigationLink(destination: ViewDataView()) {
                    HStack {
                        Image(systemName: "chart.bar")
                            .foregroundColor(Color(red: 148/255, green: 178/255, blue: 2/255))
                        Text("View Data")
                            .foregroundColor(.black)
                            .font(.headline)
                    }
                }

                NavigationLink(destination: WorkplaceDetailsView()) {
                    HStack {
                        Image(systemName: "book")
                            .foregroundColor(Color(red: 148/255, green: 178/255, blue: 2/255))
                        Text("View Workplace Details")
                            .foregroundColor(.black)
                            .font(.headline)
                    }
                }

                NavigationLink(destination: CustomerFeedbackView()) {
                    HStack {
                        Image(systemName: "face.smiling")
                            .foregroundColor(Color(red: 148/255, green: 178/255, blue: 2/255))
                        Text("Customer Feedback")
                            .foregroundColor(.black)
                            .font(.headline)
                    }
                }

                HStack {
                    Image(systemName: "square.and.arrow.down")
                        .foregroundColor(Color(red: 148/255, green: 178/255, blue: 2/255))
                    Button("View PDF Brochure") {
                        openURL(URL(string: "https://www.canva.com/design/DAFOn23KpfE/Eueuve2e40uBRa0V7cRz9w/view?utm_content=DAFOn23KpfE&utm_campaign=designshare&utm_medium=link&utm_source=publishsharelink")!)
                    }
                    .foregroundColor(.black)
                    .font(.headline)
                }

                HStack {
                    Image(systemName: "square.and.arrow.up")
                        .foregroundColor(Color(red: 148/255, green: 178/255, blue: 2/255))
                    Button("Access Telegram Channel") {
                        openURL(URL(string: "https://t.me/MoniCropFeedback")!)
                    }
                    .foregroundColor(.black)
                    .font(.headline)
                }

                NavigationLink(destination: FirstEditAccountView()) {
                    HStack {
                        Image(systemName: "person")
                            .foregroundColor(Color(red: 148/255, green: 178/255, blue: 2/255))
                        Text("Edit Account")
                            .foregroundColor(.black)
                            .font(.headline)
                    }
                }

                HStack {
                    Image(systemName: "rectangle.portrait.and.arrow.right")
                        .foregroundColor(Color(red: 148/255, green: 178/255, blue: 2/255))
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
        MenuView()
    }
}
