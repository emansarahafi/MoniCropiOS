//
//  SignInView.swift
//  MoniCrop
//
//  Created by Eman Sarah Afi on 1/6/23.
//

import SwiftUI

struct SignInPage: View {
    @State var email: String = ""
    @State var pwd: String = ""
    @EnvironmentObject var appData: ApplicationData
    
    
    var body: some View {
        VStack {
            Image("MoniCrop")
                .frame(width: 50, height: 50)
                .padding(.bottom, 150)
            Text("Sign In")
                .foregroundColor(Color(red: 148/255, green: 178/255, blue: 2/255))
                .font(.title)
                .fontWeight(.bold)
            Text("Email Address")
                .font(.system(size: 20))
                .padding()
            TextField("Insert Email", text: $email)
                .keyboardType(.emailAddress).textFieldStyle(.roundedBorder) .textInputAutocapitalization(.words)
                .font(.system(size: 20))
            Text("Password")
                .font(.system(size: 20))
            SecureTextField(text: $pwd) .textFieldStyle(.roundedBorder) .textInputAutocapitalization(.words)
                .font(.system(size: 20))
            Button {
                if appData.userData.contains(where: { user in
                    user.emailAccount != email
                    && user.password != pwd
                }) == true
                {
                    Text("Information not correct. Try again.").foregroundColor(.red)
                        .offset(y: -10)        
                }
            }
            label: {
                NavigationLink(destination: chooseDestination()) {
                    Text("Sign In")
                        .frame(maxWidth: .infinity)
                }}.buttonStyle(.borderedProminent)
                        .tint(Color(red: 148/255, green: 178/255, blue: 2/255))
                        .foregroundColor(.white)
                        .font(.system(size: 20))
                        .padding(.top)
            Button {
            }
            label: {
                NavigationLink(destination: ForgotPasswordPage()) {
                    Text("Forgot Your Password Page?").underline()
                }}                        .foregroundColor(Color(red: 148/255, green: 178/255, blue: 2/255))
                        .font(.system(size: 20))
            Button {
            }
            label: {
                NavigationLink(destination: FirstSignUpPage()) {
                    Text("Sign Up Instead")
                }}                        .foregroundColor(Color(red: 148/255, green: 178/255, blue: 2/255))
                        .font(.system(size: 20))
        }
        .padding()
        .padding(.top, 100)
    }
    
    @ViewBuilder
    func chooseDestination() -> some View {
        if appData.userData.contains(where: { user in
            user.emailAccount == email
            && user.password == pwd
        }) == true
        {
            HamburgerMenu(email : $email).navigationBarBackButtonHidden(true)
        }
        else {
            SignInPage().animation(nil)
        }
    }
}

struct SignInView_Previews: PreviewProvider {
    static var previews: some View {
        SignInPage()
    }
}
