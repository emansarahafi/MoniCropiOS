//
//  WorkplaceDetailsView.swift
//  MoniCrop
//
//  Created by Eman Sarah Afi on 1/7/26.
//

import SwiftUI

struct WorkplaceDetailsView: View {
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

struct WorkplaceDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        WorkplaceDetailsView()
    }
}