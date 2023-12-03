//
//  ViewItems.swift
//  MoniCrop
//
//  Created by Eman Sarah Afi on 1/7/23.
//

import SwiftUI

struct ViewItemsPage: View {
    @EnvironmentObject var appData: ApplicationData

    var body: some View {
        VStack {
            Text("View Items")
                .foregroundColor(Color(red: 148/255, green: 178/255, blue: 2/255))
                .font(.title)
                .fontWeight(.bold)
                List { ForEach(appData.listOfItems) { item in
                        CellItem(item: item)
                }
            }.background(Color(red: 148/255, green: 178/255, blue: 2/255))
                .scrollContentBackground(.hidden)
                .foregroundColor(Color.black)
            
        }
        .padding()
    }
}

