//
//  BreedsVM.swift
//  DogProject
//
//  Created by Talha Batuhan Irmalı on 13.12.2022.
//

import Foundation

protocol BreedsVMInterface {
    var view: BreedsViewControllerInterface? { get set }
    
    func viewDidLoad()
 
}

final class BreedsVM {
    weak var view: BreedsViewControllerInterface?
    
    var categories: [DogCategory] = []
    var populars: [Breed] = []
    var downCategories:[Breed] = []
    
    var fetchCategoriesSucceeded: ( (_ categories: [DogCategory], _ populars: [Breed], _ downCategories: [Breed]) -> Void )?
    var fetchCategoriesFailed: ( (_ errorMessage: String) -> Void )?
    
}

extension BreedsVM: BreedsVMInterface {
    
    func viewDidLoad() {
        view?.prepareCollectionView()
    }
    
    func registercell() {
        view?.registercell()
    }
    
}
