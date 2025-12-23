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
        Form {
            Section(header: Text("Profile Picture").font(.system(size: 20))) {
                CircularProfileImageView(imageState: imageState)
            }

            Section(header: Text("User's Contact Details").font(.system(size: 20))) {
                Text(user.fname).font(.system(size: 20))
                Text(user.mname).font(.system(size: 20))
                Text(user.lname).font(.system(size: 20))
                Text(user.date, format: Date.FormatStyle().year().month().day()).font(.system(size: 20))
                Text(user.gender).font(.system(size: 20))
            }
        }
        .navigationBarTitle("User Details")
        .navigationBarItems(trailing: editButton {
            self.presentEditProfileSheet.toggle()
        })
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
