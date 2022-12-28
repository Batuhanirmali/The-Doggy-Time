//
//  Presenter.swift
//  DogProject
//
//  Created by Talha Batuhan Irmalı on 18.12.2022.
//

import Foundation

// MARK: BreedsViewController Presenter 
class BreedsPresenter {

    weak var delegate: BreedsPresenterDelegate?

    func fetchCategories(){
        NetworkService.shared.fetchAllCategories { [weak self] (result) in
            switch result {
            case.success(let allBreed):
                self?.delegate?.fetchCategoriesSucceeded(allBreed.categories ?? [], allBreed.populars ?? [], allBreed.downCategories ?? [])
            case.failure(let error):
                self?.delegate?.fetchCategoriesFailed(error.localizedDescription)
            }
        }
    }
}

