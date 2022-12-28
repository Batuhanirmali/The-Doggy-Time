//
//  ListDogsVM.swift
//  DogProject
//
//  Created by Talha Batuhan Irmalı on 13.12.2022.
//

import Foundation

class ListDogsVM {
    let category: DogCategory
    var dogs: [Breed] = []
        
    init(category: DogCategory) {
            self.category = category
    }
        
    func fetchCategoryDogs(completion: @escaping (Result<[Breed], Error>) -> Void) {
        NetworkService.shared.fetchCategoryDogs(categoryId: category.id ?? "") { result in
            switch result {
            case .success(let dogs):
                self.dogs = dogs
                completion(.success(dogs))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}

