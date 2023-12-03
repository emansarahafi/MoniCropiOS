//
//  DeleteView.swift
//  MoniCrop
//
//  Created by Eman Sarah Afi on 1/7/23.
//

import SwiftUI

struct DisableDeletePage: View {
    @State var option = ""
    @State var pwd = ""

    var body: some View {
        VStack {
            Text("Delete / Disable Account")
                .foregroundColor(Color(red: 148/255, green: 178/255, blue: 2/255))
                .font(.title)
                .fontWeight(.bold)
                .padding()
            Text("Choose an option:")
                .font(.system(size: 20))
            HStack{
                RadioButtonField(
                    id: "Disable",
                    label: "Disable",
                    color:.black,
                    bgColor: .black,
                    textSize: 20,
                    isMarked: $option.wrappedValue == "Disable" ? true : false,
                        callback: { selected in
                            self.option = selected
                            print("Selected option is: \(selected)")
                        }
                    )
                RadioButtonField(
                    id: "Delete",
                    label: "Delete",
                    color:.black,
                    bgColor: .black,
                    textSize: 20,
                    isMarked: $option.wrappedValue == "Delete" ? true : false,
                        callback: { selected in
                            self.option = selected
                            print("Selected option is: \(selected)")
                    }
                )
            }
            .padding()
            Text("Please enter the password to confirm:")
                .font(.system(size: 20))
            SecureTextField(text: $pwd) .textFieldStyle(.roundedBorder) .textInputAutocapitalization(.words)
                .font(.system(size: 20))
            Text("Kindly note that if you choose: \nDisable: The account will be disabled & the user can reactivate it at any moment by logging again. \nDelete: The account will be deleted after 14 days unless the user logs in to their account again.")
                .multilineTextAlignment(.leading)
                .font(.system(size: 20))
                .padding()
            Button {
            }
            label: {
                NavigationLink(destination: LandingPage().navigationBarBackButtonHidden(true)) {
                    Text("Confirm")
                        .frame(maxWidth: .infinity)
                }}.buttonStyle(.borderedProminent)
                        .tint(Color(red: 148/255, green: 178/255, blue: 2/255))
                        .foregroundColor(.white)
                        .font(.system(size: 20))
                        .padding(.top)
        }
        .padding()
    }
}

struct DeleteView_Previews: PreviewProvider {
    static var previews: some View {
        DisableDeletePage()
    }
}
