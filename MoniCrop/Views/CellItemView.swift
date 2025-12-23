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
        HStack(alignment: .center, spacing: 16) {
            Image(item.image)
                .resizable()
                .scaledToFill()
                .frame(width: 84, height: 84)
                .clipped()
                .cornerRadius(8)

            VStack(alignment: .leading, spacing: 6) {
                Text(item.name)
                    .font(.headline)
                    .foregroundColor(Color(red: 148/255, green: 178/255, blue: 2/255))
                Text(item.date)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                Text(item.price)
                    .font(.subheadline)
                    .foregroundColor(.primary)
            }
            Spacer()
        }
        .padding(12)
        .background(Color(UIColor.systemBackground))
        .cornerRadius(10)
        .shadow(color: Color.black.opacity(0.05), radius: 4, x: 0, y: 2)
    }
}

struct CellItemView_Previews: PreviewProvider {
    static var previews: some View {
        let sampleItem = Item(image: "MoniCrop", name: "Sample", date: "2025-12-23", price: "$10")
        let vm = ItemsViewModel(item: sampleItem)
        return CellItemView(item: vm)
            .previewLayout(.sizeThatFits)
            .padding()
    }
}
