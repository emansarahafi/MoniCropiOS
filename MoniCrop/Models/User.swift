//
//  User.swift
//  MoniCrop
//
//  Created by Eman Sarah Afi on 12/23/25.
//

import Foundation

struct User: Identifiable {
    var id: String = UUID().uuidString
    var fname: String = "First"
    var mname: String = "Middle"
    var lname: String = "Last"
    var date: Date = Date()
    var gender: String = "Not specified"
}
