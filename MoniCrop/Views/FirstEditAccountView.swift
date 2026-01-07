//
//  FirstEditAccountView.swift
//  MoniCrop
//
//  Created by Eman Sarah Afi on 1/7/26.
//

import SwiftUI

struct FirstEditAccountView: View {
    @State var email: String = ""
    @State var pwd: String = ""
    @State var newpwd: String = ""
    @State var selection: String = ""
    let options = ["Select your account type", "Business Owner", "Farm Owner"]

    var body: some View {
        VStack {
            Image("MoniCrop")
                .frame(width: 50, height: 50)
                .padding(.bottom, 150)
            Text("Edit Account")
                .foregroundColor(Color(red: 148/255, green: 178/255, blue: 2/255))
                .font(.title)
                .fontWeight(.bold)
            Text("Email Address")
                .font(.system(size: 20))
                .padding()
            TextField("Insert Email", text: $email)
                .keyboardType(.emailAddress).textFieldStyle(.roundedBorder) .textInputAutocapitalization(.words)
                .font(.system(size: 20))
            Text("New Password")
                .font(.system(size: 20))
                SecureTextFieldView(text: $pwd) .textFieldStyle(.roundedBorder) .textInputAutocapitalization(.words)
            Text("Confirm Password")
                .font(.system(size: 20))
                ReSecureTextFieldView(text: $newpwd) .textFieldStyle(.roundedBorder) .textInputAutocapitalization(.words)
                .font(.system(size: 20))
            Group {
                Text("Account type")
                    .font(.system(size: 20))
                Picker("Account type", selection: $selection) {
                    ForEach(options, id: \.self) {
                        Text($0)
                    }
                }
            }
                .pickerStyle(.menu)
                .tint(Color(red: 148/255, green: 178/255, blue: 2/255))
                .font(.system(size: 20))
            Button {
                if email.isEmpty && pwd != newpwd
                {
                    Text("Password does not match. Try again.").foregroundColor(.red)
                        .offset(y: -10)
                }
            }
            label: {
                NavigationLink(destination: chooseDestination()) {
                    Text("Next")
                        .frame(maxWidth: .infinity)
                }}.buttonStyle(.borderedProminent)
                        .tint(Color(red: 148/255, green: 178/255, blue: 2/255))
                        .foregroundColor(.white)
                        .font(.system(size: 20))
                        .padding(.top)
        }
        .padding()
        .padding(.top, 50)
    }
    @ViewBuilder
    func chooseDestination() -> some View {
        if !email.isEmpty && pwd == newpwd
        {
            SecondEditAccountView(email: $email, pwd: $pwd, selection: $selection)
        }
        else {
            FirstEditAccountView().animation(nil)
        }
    }
}

struct FirstEditAccountView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            FirstEditAccountView()
        }
    }
}
