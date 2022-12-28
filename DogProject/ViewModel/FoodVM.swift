//
//  FoodVM.swift
//  DogProject
//
//  Created by Talha Batuhan Irmalı on 13.12.2022.
//

import Foundation

class FoodVM {
    // MARK: - Properties
    var dogfoods: [String]
    var nameArray: [String]
    var descriptionArray: [String]
    var filteredData: [String]!
    // MARK: Initializer
    init(dogfoods: [String], nameArray: [String], descriptionArray: [String],filteredData: [String]!) {
        self.dogfoods = dogfoods
        self.nameArray = nameArray
        self.descriptionArray = descriptionArray
        self.filteredData = dogfoods
    }
}
