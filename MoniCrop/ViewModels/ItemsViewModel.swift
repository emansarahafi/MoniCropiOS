//
//  ItemsViewModel.swift
//  MoniCrop
//
//  Created by Eman Sarah Afi on 1/7/26.
//

import Foundation

struct ItemsViewModel: Identifiable, Hashable {
    let id = UUID()
    var item: Item
    var image: String {
        return item.image
    }
    var name: String {
        return item.name
    }
    var date: String {
        return item.date
    }
    var price: String {
        return item.price
    }
}
