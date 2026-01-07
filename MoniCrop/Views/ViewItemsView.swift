//
//  ViewItemsView.swift
//  MoniCrop
//
//  Created by Eman Sarah Afi on 1/7/26.
//

import SwiftUI

struct ViewItemsView: View {
    @EnvironmentObject var appData: ApplicationData

    var body: some View {
        VStack {
            Text("View Items")
                .foregroundColor(Color(red: 148/255, green: 178/255, blue: 2/255))
                .font(.title)
                .fontWeight(.bold)
                List { ForEach(appData.listOfItems) { item in
                        CellItemView(item: item)
                }
            }.background(Color(red: 148/255, green: 178/255, blue: 2/255))
                .scrollContentBackground(.hidden)
                .foregroundColor(Color.black)
            
        }
        .padding()
    }
}

struct ViewItemsView_Previews: PreviewProvider {
    static var previews: some View {
        ViewItemsView()
            .environmentObject(ApplicationData())
    }
}
