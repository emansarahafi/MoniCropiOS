//
//  Feedback.swift
//  MoniCrop
//
//  Created by Eman Sarah Afi on 2/22/26.
//

import Foundation

struct Feedback: Identifiable, Codable {
    var id: String = UUID().uuidString
    var email: String
    var message: String
    var timestamp: Date
    
    var formattedDate: String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        return formatter.string(from: timestamp)
    }
}
