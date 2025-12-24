//
//  LandingView.swift
//  MoniCrop
//
//  Created by Eman Sarah Afi on 12/2/22.
//

import SwiftUI

struct LandingView: View {

    var body: some View {
        NavigationStack {
            VStack {
                Image("MoniCrop")
                    .frame(width: 50, height: 50)
                    .padding(.bottom, 200)
                    .accessibilityLabel("MoniCrop logo")
                NavigationLink(destination: SignInView()) {
                    Text("Sign In")
                    .frame(maxWidth: .infinity)
                }
                .primaryButtonStyle()
                .accessibilityLabel("Sign in")
                .accessibilityIdentifier("landingSignInButton")
                .accessibilityHint("Go to sign in screen")
                .bodyStyle()
                .padding(.top)
                NavigationLink(destination: FirstSignUpView()) {
                    Text("Sign Up")
                    .frame(maxWidth: .infinity)
                }
                .primaryButtonStyle()
                .accessibilityLabel("Sign up")
                .accessibilityIdentifier("landingSignUpButton")
                .accessibilityHint("Go to sign up screen")
                .bodyStyle()
                .padding(.top)
                NavigationLink(destination: AboutUsView()) {
                    Text("About Us")
                }
                .foregroundColor(Color.accent)
                .bodyStyle()
                .padding(.top)
            }
        }.accentColor(.black)
        .padding()
    }
}

struct LandingView_Previews: PreviewProvider {
    static var previews: some View {
        LandingView()
    }
}
