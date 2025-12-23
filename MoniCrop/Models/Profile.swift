//
//  Profile.swift
//  MoniCrop
//
//  Created by Eman Sarah Afi on 12/23/25.
//

import Foundation

struct Profile {
    enum ImageState {
        case empty
        case loading
        case loaded(Data)
    }
}