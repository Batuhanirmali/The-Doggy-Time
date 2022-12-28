//
//  Route.swift
//  DogProject
//
//  Created by Talha Batuhan Irmalı on 29.11.2022.
//

import Foundation


enum Route {
    // MARK: Project's address
    static let baseUrl = "https://dogtime.glitch.me"

    case fetchAllCategories
    case favoriteDogs(String)
    case fetchCategoryDogs(String)
    case fetchFavoriteDogs
    
    // MARK: Category paths.
    var description: String {
        switch self {

        case .fetchAllCategories:
            return "/breed-categories"
        case .favoriteDogs(let dogId):
            return "/favorites/\(dogId)"
        case.fetchCategoryDogs(let categoryId):
            return "/dogs/\(categoryId)"
        case.fetchFavoriteDogs:
            return "/favorites"
        }
    }
}
