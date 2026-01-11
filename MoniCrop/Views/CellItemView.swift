//  CellItemView.swift
//  MoniCrop
//
//  Created by Eman Sarah Afi on 1/7/26.
//

import SwiftUI

struct CellItemView: View {
    let item: ItemsViewModel
    var body: some View {
        HStack {
            Image(item.image)
                .resizable()
                .scaledToFit()
                .frame(width: 100, height: 100)
            VStack (alignment: .leading){
                Text("Item: \(item.name)").bold()
                Text("Date: \(item.date)").bold()
                Text("Price: \(item.price)").bold()
            }
        }
    }
}

struct CellItemView_Previews: PreviewProvider {
    static var previews: some View {
        CellItemView(item: ItemsViewModel(item: Item(image: "apple", name: "Sample", date: "Today", price: "$1")))
            .previewLayout(.sizeThatFits)
    }
}
