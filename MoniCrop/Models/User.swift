//
//  User.swift
//  MoniCrop
//
//  Created by Eman Sarah Afi on 12/23/25.
//

import Foundation

struct User: Identifiable {
    var id: String = UUID().uuidString
    var fname: String = ""
    var mname: String = ""
    var lname: String = ""
    var email: String? = nil
    var date: Date = Date()
    var accountType: String = ""
    var workplaceName: String = ""
    var position: String = ""
}
