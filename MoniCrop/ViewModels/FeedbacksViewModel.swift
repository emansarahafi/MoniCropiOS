//
//  FeedbacksViewModel.swift
//  MoniCrop
//
//  Created by Eman Sarah Afi on 2/22/26.
//

import Foundation

class FeedbacksViewModel: ObservableObject {
    @Published var feedbackList: [Feedback] = []
    
    private let feedbackKey = "savedFeedback"
    
    init() {
        loadFeedback()
    }
    
    // MARK: - Persistence
    
    func saveFeedback() {
        if let encoded = try? JSONEncoder().encode(feedbackList) {
            UserDefaults.standard.set(encoded, forKey: feedbackKey)
        }
    }
    
    func loadFeedback() {
        if let data = UserDefaults.standard.data(forKey: feedbackKey),
           let feedback = try? JSONDecoder().decode([Feedback].self, from: data) {
            feedbackList = feedback
        }
    }
    
    // MARK: - Feedback Management
    
    func addFeedback(email: String, message: String) {
        let newFeedback = Feedback(
            email: email,
            message: message,
            timestamp: Date()
        )
        feedbackList.append(newFeedback)
        saveFeedback()
    }
    
    func deleteFeedback(at offsets: IndexSet) {
        feedbackList.remove(atOffsets: offsets)
        saveFeedback()
    }
    
    func clearAllFeedback() {
        feedbackList.removeAll()
        saveFeedback()
    }
    
    // MARK: - Computed Properties
    
    var feedbackCount: Int {
        return feedbackList.count
    }
    
    var recentFeedback: [Feedback] {
        return Array(feedbackList.sorted(by: { $0.timestamp > $1.timestamp }).prefix(5))
    }
}
