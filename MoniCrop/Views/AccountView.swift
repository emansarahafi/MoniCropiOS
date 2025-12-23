//
//  AccountView.swift
//  MoniCrop
//
//  Created by Eman Sarah Afi on 1/7/23.
//

import SwiftUI

struct AccountView: View {
    // MARK: - State

struct AccountView_Previews: PreviewProvider {
    static var previews: some View {
        // AccountView requires a `User` model and ProfileModel.ImageState in the app.
        // Provide a simple static mock preview instead of instantiating the real view.
        VStack(spacing: 8) {
            Text("User Details Preview")
                .font(.title)
                .fontWeight(.bold)
            Text("First Last")
            Text("Joined: Jan 01, 1990")
            Text("Gender: Not specified")
        }
        .padding()
        .previewLayout(.sizeThatFits)
    }
}
    
    @Environment(\.presentationMode) var presentationMode
    @State var presentEditProfileSheet = false
    let imageState: ProfileModel.ImageState
    
    // MARK: - State (Initialiser-modifiable)
    
    var user: User
    
    // MARK: - UI Components
    
    private func editButton(action: @escaping () -> Void) -> some View {
        Button(action: { action() }) {
            Text("Edit")
        }
    }
    
    static let stackDateFormat: DateFormatter = {
            let formatter = DateFormatter()
            formatter.dateFormat = "E, dd MMM yyyy HH:mm:ss z"
            return formatter
        }()
    
    var body: some View {
        Form {
            Section(header: Text("Profile Picture").font(.system(size: 20))) {
                CircularProfileImage(imageState: imageState)
            }
            
            Section(header: Text("User's Contact Details").font(.system(size: 20))) {
                Text(user.fname)
                    .font(.system(size: 20))
                Text(user.mname)
                    .font(.system(size: 20))
                Text(user.lname)
                    .font(.system(size: 20))
                Text(user.date, format: Date.FormatStyle().year().month().day())
                    .font(.system(size: 20))
                Text(user.gender)
                    .font(.system(size: 20))
            }

            Section(header: Text("User's Information").font(.system(size: 20))) {
                Text(user.fname)
                    .font(.system(size: 20))
                Text(user.mname)
                    .font(.system(size: 20))
                Text(user.lname)
                    .font(.system(size: 20))
                Text(user.date, format: Date.FormatStyle().year().month().day())
                    .font(.system(size: 20))
                Text(user.gender)
                    .font(.system(size: 20))
            }
                        
        }
        .navigationBarTitle("User Details")
        .navigationBarItems(trailing: editButton {
          self.presentEditProfileSheet.toggle()
        })
                .onAppear() {
                    print("AccountView.onAppear() for User Details")
                }
                .onDisappear() {
                    print("AccountView.onDisappear()")
                }
        .sheet(isPresented: self.$presentEditProfileSheet) {
          EditProfileView(viewModel1: UserViewModel(user: user), mode: .edit) { result in
            if case .success(let action) = result, action == .delete {
              self.presentationMode.wrappedValue.dismiss()
            }
          }
        }
      }
      
    }
