//
//  CellItemView.swift
//  MoniCrop
//
//  Created by Eman Sarah Afi on 12/23/25.
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
        let sampleItem = Items(image: "MoniCrop", name: "Sample", date: "2025-12-23", price: "$10")
        let vm = ItemsViewModel(item: sampleItem)
        return CellItemView(item: vm)
            .previewLayout(.sizeThatFits)
            .padding()
    }
}
