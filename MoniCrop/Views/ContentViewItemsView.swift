//
//  ContentViewItemsView.swift
//  MoniCrop
//
//  Created by Eman Sarah Afi on 12/23/25.
//

import SwiftUI

struct ContentViewItemsView: View {
    @EnvironmentObject var appData: ApplicationData

    var body: some View {
        VStack {
            Text("View Items")
                .foregroundColor(Color.accent)
                .titleStyle()
                .fontWeight(.bold)

            List {
                ForEach(appData.listOfItems) { item in
                    CellItemView(item: item)
                        .listRowBackground(Color.clear)
                        .padding(.vertical, 4)
                }
            }
            .listStyle(PlainListStyle())
            .scrollContentBackground(.hidden)
            .background(Color(UIColor.systemGroupedBackground))
            .padding(.top, 8)
            .onAppear {
                appData.loadData()
            }
        }
    }
}

struct ContentViewItemsView_Previews: PreviewProvider {
    static var previews: some View {
        let mock = ApplicationData()
        mock.listOfItems = [
            ItemsViewModel(item: Item(image: "apple", name: "Apple", date: "2025-12-23", price: "$1.00")),
            ItemsViewModel(item: Item(image: "carrot", name: "Carrot", date: "2025-12-22", price: "$0.50"))
        ]
        return NavigationStack {
            ContentViewItemsView().environmentObject(mock)
        }
    }
}
