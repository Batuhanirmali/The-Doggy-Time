//
//  DetailVM.swift
//  DogProject
//
//  Created by Talha Batuhan Irmalı on 13.12.2022.
//

import Foundation


protocol DetailVMInterface {
    var view: DetailViewControllerInterface? { get set }
    func viewDidLoad()
}

final class DetailVM {
    weak var view: DetailViewControllerInterface?
    
}

extension DetailVM: DetailVMInterface {
    func viewDidLoad() {
        view?.praparePage()
    }
    
    
}
