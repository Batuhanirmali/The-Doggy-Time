//
//  ListFavoritesVM.swift
//  DogProject
//
//  Created by Talha Batuhan Irmalı on 13.12.2022.
//

import Foundation

protocol ListFavoritesVMInterface {
    var view: ListFavoritesViewControllerInterface? { get set }
    func viewDidLoad()
    func registerCells()
    func fetchpresenter()
}

final class ListFavoritesVM {
    weak var view: ListFavoritesViewControllerInterface?
    var favorites: [Favorite] = []
    var fetchFavoritesSucceeded: ( (_ favorites: [Favorite]) -> Void )?
    var fetchFavoritesFailed: ( (_ errorMessage: String) -> Void )?
}

extension ListFavoritesVM: ListFavoritesVMInterface {
    func fetchpresenter() {
        NetworkService.shared.fetchFavoriteDogs { [weak self] (result) in
            switch result {
            case.success(let favorites):
                self?.fetchFavoritesSucceeded?(favorites)
            case.failure(let error):
                self?.fetchFavoritesFailed?(error.localizedDescription)
            }
        }
    }
    
    
    func viewDidLoad() {
        view?.prepareView()
    }
    
    func registerCells() {
        view?.register()
    }
    
}

