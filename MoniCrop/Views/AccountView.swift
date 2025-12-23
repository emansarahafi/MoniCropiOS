//
//  AccountView.swift
//  MoniCrop
//
//  Created by Eman Sarah Afi on 1/7/23.
//

import SwiftUI

struct AccountView: View {
    @Environment(\.presentationMode) var presentationMode
    @State private var presentEditProfileSheet = false

    // Image state comes from the `Profile` model.
    var imageState: Profile.ImageState

    // The user to display.
    var user: User

    private func editButton(action: @escaping () -> Void) -> some View {
        Button(action: { action() }) {
            Text("Edit")
        }
    }

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                HStack(alignment: .center, spacing: 16) {
                    CircularProfileImageView(imageState: imageState)
                        .frame(width: 96, height: 96)
                        .shadow(radius: 4)

                    VStack(alignment: .leading, spacing: 6) {
                        Text("\(user.fname) \(user.lname)")
                            .font(.title2)
                            .fontWeight(.semibold)
                        Text(user.email ?? "No email")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                    }
                    Spacer()
                }

                VStack(alignment: .leading, spacing: 12) {
                    Group {
                        Label("First name", systemImage: "person.fill")
                            .font(.headline)
                        Text(user.fname).font(.body)

                        Label("Middle name", systemImage: "person")
                            .font(.headline)
                        Text(user.mname).font(.body)

                        Label("Last name", systemImage: "person.fill")
                            .font(.headline)
                        Text(user.lname).font(.body)

                        Label("Date of birth", systemImage: "calendar")
                            .font(.headline)
                        Text(user.date, format: Date.FormatStyle().year().month().day())
                            .font(.body)

                        Label("Gender", systemImage: "g.circle")
                            .font(.headline)
                        Text(user.gender).font(.body)
                    }
                }
                .padding(.top, 6)

                Spacer()
            }
            .padding()
        }
        .navigationTitle("User Details")
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: { self.presentEditProfileSheet.toggle() }) {
                    Text("Edit")
                }
                .buttonStyle(.bordered)
            }
        }
        .onAppear { print("AccountView.onAppear() for User Details") }
        .onDisappear { print("AccountView.onDisappear()") }
        .sheet(isPresented: self.$presentEditProfileSheet) {
            FirstEditAccountView(onComplete: { action in
                if case .delete = action {
                    self.presentationMode.wrappedValue.dismiss()
                }
            })
            .environmentObject(UsersViewModel(user: user))
        }
    }
}

struct AccountView_Previews: PreviewProvider {
    static var previews: some View {
        AccountView(imageState: .empty, user: User())
            .padding()
            .previewLayout(.sizeThatFits)
    }
}
