//
//  WorkplaceView.swift
//  MoniCrop
//
//  Created by Eman Sarah Afi on 1/7/23.
//

import SwiftUI

struct WorkplaceDetailsPage: View {
    var body: some View {
        VStack {
            Text("Workplace Details")
                .foregroundColor(Color(red: 148/255, green: 178/255, blue: 2/255))
                .font(.title)
                .fontWeight(.bold)
            Group {
                Text("\(Text("Name: ").bold())Company Inc.")
                Text("\(Text("Founding Date: ").bold())22 Oct 2000")
                Text("\(Text("Joined MoniCrop on: ").bold())13 Oct 2022")
                Text("\(Text("Items: ").bold())Mango, Apple, Carrot, Strawberry & Pear.")
            }
            .multilineTextAlignment(.center)
            .font(.system(size: 20))
            .padding()
        }
        .padding()
    }
}

struct WorkplaceView_Previews: PreviewProvider {
    static var previews: some View {
        WorkplaceDetailsPage()
    }
}
