//
//  LandingView.swift
//  MoniCrop
//
//  Created by Eman Sarah Afi on 1/7/26.
//

import SwiftUI

struct LandingView: View {
    var body: some View {
        NavigationStack {
            VStack {
                Image("MoniCrop")
                    .frame(width: 50, height: 50)
                    .padding(.bottom, 200)
                
                NavigationLink(destination: SignInView()) {
                    Text("Sign In")
                        .frame(maxWidth: .infinity)
                }
                .buttonStyle(.borderedProminent)
                .tint(Color(red: 148/255, green: 178/255, blue: 2/255))
                .foregroundColor(.white)
                .font(.system(size: 20))
                .padding(.top)
                
                NavigationLink(destination: FirstSignUpView()) {
                    Text("Sign Up")
                        .frame(maxWidth: .infinity)
                }
                .buttonStyle(.borderedProminent)
                .tint(Color(red: 148/255, green: 178/255, blue: 2/255))
                .foregroundColor(.white)
                .font(.system(size: 20))
                .padding(.top)
                
                NavigationLink(destination: AboutUsView()) {
                    Text("About Us")
                }
                .foregroundColor(Color(red: 148/255, green: 178/255, blue: 2/255))
                .font(.system(size: 20))
                .padding(.top)
            }
            .padding()
        }
        .tint(.black)
    }
}

struct LandingView_Previews: PreviewProvider {
    static var previews: some View {
        LandingView()
            .environmentObject(ApplicationData())
            .environmentObject(UsersViewModel())
    }
}
