//
//  ApplicationData.swift
//  MoniCrop
//
//  Created by Eman Sarah Afi on 1/7/26.
//

import Foundation

class ApplicationData: ObservableObject {
    @Published var listOfItems: [ItemsViewModel]
    @Published var userData: [User]
    
    private let usersKey = "savedUsers"
    private let itemsKey = "savedItems"
    
    init() {
        // Try to load saved data first
        if let savedUsers = ApplicationData.loadUsers() {
            userData = savedUsers
        } else {
            // Default data for first launch
            userData = [
                User(emailAccount: "Person1@email.com", password: "1234", accountType: "Farmer", firstName: "Person1Fname", middleName: "Person1Mname", lastName: "Person1Lname", workPlaceName: "Person1WorkPlaceName", workPlacePosition: "Person1WorkPlacePosition", date: Date()),
                
                User(emailAccount: "Person2@email.com", password: "1234", accountType: "Business", firstName: "Person2Fname", middleName: "Person2Mname", lastName: "Person2Lname", workPlaceName: "Person2WorkPlaceName", workPlacePosition: "Person2WorkPlacePosition", date: Date())
            ]
        }
        
        listOfItems = [
            ItemsViewModel(item: Item(image: "mango", name: "Mango", date: "22 Nov 2022", price: "2 BHD")),
            ItemsViewModel(item: Item(image: "apple", name: "Apple", date: "20 Dec 2022", price: "5 BHD")),
            ItemsViewModel(item: Item(image: "carrot", name: "Carrot", date: "10 Dec 2022", price: "3 BHD")),
            ItemsViewModel(item: Item(image: "strawberry", name: "Strawberry", date: "13 Oct 2022", price: "6 BHD")),
            ItemsViewModel(item: Item(image: "pear", name: "Pear", date: "17 Oct 2022", price: "4 BHD")),
        ]
    }
    
    // MARK: - Persistence
    
    func saveData() {
        if let encoded = try? JSONEncoder().encode(userData) {
            UserDefaults.standard.set(encoded, forKey: usersKey)
        }
    }
    
    static func loadUsers() -> [User]? {
        if let data = UserDefaults.standard.data(forKey: "savedUsers"),
           let users = try? JSONDecoder().decode([User].self, from: data) {
            return users
        }
        return nil
    }
    
    // MARK: - User Management
    
    func addUser(_ user: User) {
        userData.append(user)
        saveData()
    }
    
    func updateUser(email: String, with updatedUser: User) {
        if let index = userData.firstIndex(where: { $0.emailAccount == email }) {
            userData[index] = updatedUser
            saveData()
        }
    }
    
    func deleteUser(email: String) {
        userData.removeAll { $0.emailAccount == email }
        saveData()
    }
    
    func findUser(email: String, password: String) -> User? {
        return userData.first { $0.emailAccount == email && $0.password == password }
    }
}
