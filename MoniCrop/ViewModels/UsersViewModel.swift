//
//  UsersViewModel.swift
//  MoniCrop
//
//  Created by Eman Sarah Afi on 12/23/25.
//

import Foundation
import Combine

final class UsersViewModel: ObservableObject {
    @Published var user: User

    init(user: User) {
        self.user = user
    }
}
