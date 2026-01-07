//
//  SecondSignUpView.swift
//  MoniCrop
//
//  Created by Eman Sarah Afi on 1/7/26.
//

import SwiftUI

struct SecondSignUpView: View {
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
            HamburgerMenuView(email: $email).navigationBarBackButtonHidden(true)
        }
        else {
            SecondSignUpView(email: $email, pwd: $pwd, selection: $selection).animation(nil)
        }
    }
}

struct SecondSignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SecondSignUpView(email: .constant("test@example.com"), pwd: .constant("password"), selection: .constant("Business Owner"))
            .environmentObject(ApplicationData())
    }
}
