//
//  SecondEditAccountView.swift
//  MoniCrop
//
//  Created by Eman Sarah Afi on 1/7/26.
//

import SwiftUI

struct SecondEditAccountView: View {
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
            }
            label: {
                NavigationLink(destination: chooseDestination()) {
                    Text("Update Account")
                        .frame(maxWidth: .infinity)
                }}.buttonStyle(.borderedProminent)
                        .tint(Color(red: 148/255, green: 178/255, blue: 2/255))
                        .foregroundColor(.white)
                        .font(.system(size: 20))
                        .padding(.top)
            Button {
            }
            label: {
                NavigationLink(destination: DisableDeleteView()) {
                    Text("Disable or Delete Your Account")
                }}                        .foregroundColor(Color(red: 148/255, green: 178/255, blue: 2/255))
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
            SecondEditAccountView(email: $email, pwd: $pwd, selection: $selection).animation(nil)
        }
    }
}

struct SecondEditAccountView_Previews: PreviewProvider {
    static var previews: some View {
        SecondEditAccountView(email: .constant("test@example.com"), pwd: .constant("password"), selection: .constant("Farmer"))
            .environmentObject(ApplicationData())
    }
}
