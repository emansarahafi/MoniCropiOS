//
//  UsersViewModel.swift
//  MoniCrop
//
//  Created by Eman Sarah Afi on 12/23/25.
//

import Foundation
import Combine
import FirebaseAuth
import FirebaseFirestore

final class UsersViewModel: ObservableObject {
    @Published var user: User

    init(user: User) {
        self.user = user
    }

    func loadCurrentUser() {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        Firestore.firestore().collection("users").document(uid).getDocument { [weak self] snapshot, error in
            if let error = error {
                print("UsersViewModel: error loading user: \(error)")
                return
            }
            guard let data = snapshot?.data() else { return }
            DispatchQueue.main.async {
                self?.user.id = uid
                self?.user.fname = data["firstName"] as? String ?? ""
                self?.user.mname = data["middleName"] as? String ?? ""
                self?.user.lname = data["lastName"] as? String ?? ""
                self?.user.email = data["email"] as? String
                if let dob = (data["dob"] as? Timestamp)?.dateValue() {
                    self?.user.date = dob
                }
                self?.user.accountType = data["accountType"] as? String ?? ""
                self?.user.workplaceName = data["workplaceName"] as? String ?? ""
                self?.user.position = data["position"] as? String ?? ""
            }
        }
    }
}
