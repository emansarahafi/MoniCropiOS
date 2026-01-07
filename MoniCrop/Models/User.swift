//
//  User.swift
//  MoniCrop
//
//  Created by Eman Sarah Afi on 1/7/26.
//

import Foundation

struct User: Identifiable {
    let id = UUID()
    var emailAccount: String = ""
    var password: String = ""
    var accountType: String = ""
    var firstName: String = ""
    var middleName: String = ""
    var lastName: String = ""
    var workPlaceName: String = ""
    var workPlacePosition: String = ""
    var date: Date
}
