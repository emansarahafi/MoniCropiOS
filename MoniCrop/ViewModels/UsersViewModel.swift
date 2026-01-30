//
//  UsersViewModel.swift
//  MoniCrop
//
//  Created by Eman Sarah Afi on 1/30/26.
//

import Foundation

class UsersViewModel: ObservableObject {
    @Published var currentUser: User?
    @Published var isLoggedIn: Bool = false
    
    private let currentUserKey = "currentUserEmail"
    
    init() {
        // Check if there was a logged-in user from last session
        restoreSession()
    }
    
    // MARK: - Authentication
    
    func login(email: String, password: String, users: [User]) -> Bool {
        if let user = users.first(where: { $0.emailAccount == email && $0.password == password }) {
            currentUser = user
            isLoggedIn = true
            // Save session
            UserDefaults.standard.set(email, forKey: currentUserKey)
            return true
        }
        return false
    }
    
    func logout() {
        currentUser = nil
        isLoggedIn = false
        UserDefaults.standard.removeObject(forKey: currentUserKey)
    }
    
    func restoreSession() {
        // This will be called with users array from ApplicationData
        if let savedEmail = UserDefaults.standard.string(forKey: currentUserKey) {
            // We'll restore the full user when ApplicationData loads
            isLoggedIn = !savedEmail.isEmpty
        }
    }
    
    func restoreUser(from users: [User]) {
        if let savedEmail = UserDefaults.standard.string(forKey: currentUserKey),
           let user = users.first(where: { $0.emailAccount == savedEmail }) {
            currentUser = user
            isLoggedIn = true
        }
    }
    
    // MARK: - User Updates
    
    func updateCurrentUser(with updatedUser: User, in appData: ApplicationData) {
        guard let currentUser = currentUser else { return }
        
        // Find and update the user in the array
        if let index = appData.userData.firstIndex(where: { $0.emailAccount == currentUser.emailAccount }) {
            appData.userData[index] = updatedUser
            self.currentUser = updatedUser
            
            // Update saved email if it changed
            UserDefaults.standard.set(updatedUser.emailAccount, forKey: currentUserKey)
            
            // Persist the changes
            appData.saveData()
        }
    }
    
    func deleteCurrentUser(from appData: ApplicationData) {
        guard let currentUser = currentUser else { return }
        
        appData.userData.removeAll { $0.emailAccount == currentUser.emailAccount }
        appData.saveData()
        logout()
    }
}
