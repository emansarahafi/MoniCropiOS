//
//  SignUpView.swift
//  MoniCrop
//
//  Created by Eman Sarah Afi on 1/6/23.
//

import SwiftUI

struct FirstSignUpPage: View {
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
                SecureTextField(text: $pwd) .textFieldStyle(.roundedBorder) .textInputAutocapitalization(.words)
                    .font(.system(size: 20))
                Text("Confirm Password")
                    .font(.system(size: 20))
                ReSecureTextField(text: $cpwd) .textFieldStyle(.roundedBorder) .textInputAutocapitalization(.words)
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
            SecondSignUpPage(email: $email, pwd: $pwd, selection: $selection)
        }
        else {
            FirstSignUpPage().animation(nil)
        }
    }
}

struct SecondSignUpPage: View {
    @Binding var email: String
    @Binding var pwd: String
    @Binding var selection: String
    @State var date = Date()
    @State var fname: String = ""
    @State var mname: String = ""
    @State var lname: String = ""
    @State var wname: String = ""
    @State var position: String = ""
    @EnvironmentObject var appData: ApplicationData

    var body: some View {
        VStack {
            Group {
                Text("First Name")
                    .font(.system(size: 20))
                TextField("Insert First Name", text: $fname) .textFieldStyle(.roundedBorder) .textInputAutocapitalization(.words)
                    .font(.system(size: 20))
                Text("Middle Name")
                    .font(.system(size: 20))
                TextField("Insert Middle Name", text: $mname) .textFieldStyle(.roundedBorder) .textInputAutocapitalization(.words)
                    .font(.system(size: 20))
                Text("Last Name")
                    .font(.system(size: 20))
                TextField("Insert Last Name", text: $lname) .textFieldStyle(.roundedBorder) .textInputAutocapitalization(.words)
                    .font(.system(size: 20))
            }
            DatePicker("Date of Birth",
                        selection: $date,
                        in: ...Date(),
                        displayedComponents: [.date])
            .font(.system(size: 20))
                        .padding()
            Text("Workplace Name")
                .font(.system(size: 20))
            TextField("Insert Workplace Name", text: $wname) .textFieldStyle(.roundedBorder) .textInputAutocapitalization(.words)
                .font(.system(size: 20))
            Text("Position")
                .font(.system(size: 20))
            TextField("Insert Position", text: $position) .textFieldStyle(.roundedBorder) .textInputAutocapitalization(.words)
                .font(.system(size: 20))
            Button {
                if !fname.isEmpty && !mname.isEmpty && !lname.isEmpty && !wname.isEmpty && !position.isEmpty
                {
                    appData.userData.append(User(emailAccount: email, password: pwd, accountType: selection, firstName: fname, middleName: mname, lastName: lname, workPlaceName: wname, workPlacePosition: wname, date: date))
                }
                else {
                    Text("Please ensure everything is filled.").foregroundColor(.red)
                        .offset(y: -10)
                }
                
            }
            label: {
                NavigationLink(destination: chooseDestination()) {
                    Text("Sign Up")
                        .frame(maxWidth: .infinity)
                }}.buttonStyle(.borderedProminent)
                        .tint(Color(red: 148/255, green: 178/255, blue: 2/255))
                        .foregroundColor(.white)
                        .font(.system(size: 20))
                        .padding(.top)
        }
        .padding()
    }
    @ViewBuilder
    func chooseDestination() -> some View {
        if !fname.isEmpty && !mname.isEmpty && !lname.isEmpty && !wname.isEmpty && !position.isEmpty
        {
            HamburgerMenu(email: $email).navigationBarBackButtonHidden(true)
        }
        else {
            SecondSignUpPage(email: $email, pwd: $pwd, selection: $selection).animation(nil)
        }
    }
}
struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        FirstSignUpPage()
    }
}
