//
//  AppstoreReviewManager.swift
//  DogProject
//
//  Created by Talha Batuhan Irmalı on 20.01.2023.
//

import Foundation
import StoreKit

class ReviewService {
    private init() {}
    static let shared = ReviewService()
    
    private let defaults = UserDefaults.standard
    private var lastRequest: Date? {
        get {
            return defaults.value(forKey: "ReviewService.lastRequest") as? Date
        }
        set {
            defaults.set(newValue, forKey: "ReviewService.lastRequest")
        }
    }
    
    private var oneWeekAgo: Date {
        return Calendar.current.date(byAdding: .day, value: -7, to: Date())!
    }
    private var shouldRequestReview: Bool {
        if lastRequest == nil {
            return true
        } else if let lastRequest = self.lastRequest, lastRequest < oneWeekAgo {
            return true
        }
        return false
    }
    
    func requestReview() {
        //let scene = UIApplication.shared.connectedScenes.first as? UIWindowScene
        guard shouldRequestReview else {return}
        guard let scene = UIApplication.shared.foregroundActiveScene else { return }
        if #available(iOS 14.0, *) {
            SKStoreReviewController.requestReview(in: scene)
        } else {
            // Fallback on earlier versions
        }
        lastRequest = Date()
    }
    
    
    
}
extension UIApplication {
    var foregroundActiveScene: UIWindowScene? {
        connectedScenes
            .first(where: { $0.activationState == .foregroundActive }) as? UIWindowScene
    }
}
