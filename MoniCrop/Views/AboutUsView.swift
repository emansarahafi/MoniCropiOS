//
//  AboutUsView.swift
//  MoniCrop
//
//  Created by Eman Sarah Afi on 12/23/25.
//

import SwiftUI

struct AboutUsView: View {
    
    var body: some View {
        VStack {
            Image("MoniCrop")
                .frame(width: 50, height: 50)
                .padding(.bottom, 150)
            Text("MoniCrop is an iOS application developed by two students in 2022 from the American University of Bahrain (AUBH), Ali Abdulla & Eman Sarah Afi.")
                .font(.system(size: 18))
                .multilineTextAlignment(.leading)
                .padding()
            Text("The purpose of this application is for the user being able to monitor their crop, check any essential information, and communicate with specific users at any moment of the day.")
                .font(.system(size: 18))
                .multilineTextAlignment(.leading)
                .padding()
        }
        .padding()
        .padding(.top, 20)
    }
}

struct AboutUsView_Previews: PreviewProvider {
    static var previews: some View {
        AboutUsView()
            .previewLayout(.sizeThatFits)
            .padding()
    }
}
