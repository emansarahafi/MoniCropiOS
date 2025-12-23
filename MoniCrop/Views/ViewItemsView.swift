//
//  ViewItemsView.swift
//  MoniCrop
//
//  Created by Eman Sarah Afi on 1/7/23.
//

import SwiftUI
import FirebaseFirestore

let appData = ApplicationData()

struct ViewItemsView: View {
    var body: some View {
        ContentViewItemsView()
            .environmentObject(appData)
    }
}

struct ViewItemsView_Previews: PreviewProvider {
    static var previews: some View {
        let mock = ApplicationData()
        mock.listOfItems = [
            ItemsViewModel(item: Items(image: "apple", name: "Apple", date: "2025-12-23", price: "$1.00")),
            ItemsViewModel(item: Items(image: "carrot", name: "Carrot", date: "2025-12-22", price: "$0.50"))
        ]
        return ContentViewItemsView().environmentObject(mock)
    }
}

