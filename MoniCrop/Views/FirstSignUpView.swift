//
//  FirstSignUpView.swift
//  MoniCrop
//
//  Created by Eman Sarah Afi on 1/7/26.
//

import SwiftUI

struct FirstSignUpView: View {
    @State var selection = "Select your account type"
    let options = ["Select your account type", "Business Owner", "Farm Owner"]
    @State var date = Date()
    @State var email: String = ""
    @State var pwd: String = ""
    @State var cpwd: String = ""
    @EnvironmentObject var appData: ApplicationData

    var body: some View {
        VStack {
            Image("MoniCrop")
                .frame(width: 50, height: 50)
                .padding(.bottom, 60)
            Text("Sign Up")
                .foregroundColor(Color(red: 148/255, green: 178/255, blue: 2/255))
                .font(.title)
                .fontWeight(.bold)
                .padding(.top, 50)
            Group {
                Text("Email Address")
                    .font(.system(size: 20))
                    .padding(.top, 10)
                TextField("Insert Email", text: $email)
                    .keyboardType(.emailAddress).textFieldStyle(.roundedBorder) .textInputAutocapitalization(.words)
                    .font(.system(size: 20))
                Text("Password")
                    .font(.system(size: 20))
                SecureTextFieldView(text: $pwd) .textFieldStyle(.roundedBorder) .textInputAutocapitalization(.words)
                    .font(.system(size: 20))
                Text("Confirm Password")
                    .font(.system(size: 20))
                ReSecureTextFieldView(text: $cpwd) .textFieldStyle(.roundedBorder) .textInputAutocapitalization(.words)
                    .font(.system(size: 20))
            }
            Group {
                Text("Account type")
                    .font(.system(size: 20))
                Picker("Account type", selection: $selection) {
                    ForEach(options, id: \.self) {
                        Text($0)
                    }
                }
                .pickerStyle(.menu)
                .tint(Color(red: 148/255, green: 178/255, blue: 2/255))
                .font(.system(size: 20))
                Button {
                    if email.isEmpty && pwd != cpwd
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
        }
        .padding()
        .padding(.top, 70)
    }
    @ViewBuilder
    func chooseDestination() -> some View {
        if !email.isEmpty && pwd == cpwd
        {
            SecondSignUpView(email: $email, pwd: $pwd, selection: $selection)
        }
        else {
            FirstSignUpView().animation(nil)
        }
    }
}

struct FirstSignUpView_Previews: PreviewProvider {
    static var previews: some View {
        FirstSignUpView()
    }
}
