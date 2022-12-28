//
//  FavoriteDetailVM.swift
//  DogProject
//
//  Created by Talha Batuhan Irmalı on 6.12.2022.
//

import Foundation


protocol FavoriteDetailVMOutput {
    func showProgress(isShow: Bool)
}

final class FavoriteDetailVM {
    var delegate: FavoriteDetailVMOutput?
    
    
    func addFavoriteDogName(dogId: String, name: String) {
        
        NetworkService.shared.favoriteDogs(dogId: dogId , name: name) { (result) in
            switch result {
            case.success(_):
                self.delegate?.showProgress(isShow: true)
            case .failure(let error): break
               // ProgressHUD.showError(error.localizedDescription)
            }
        }
    }
    
    
}


